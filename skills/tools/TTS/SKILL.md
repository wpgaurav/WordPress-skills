---
name: tts
description: "Convert text to speech using ElevenLabs with emotional audio tags, pronunciation control, and blog-to-audio workflows"
---

# ElevenLabs Text-to-Speech Skill

Generate natural, expressive speech from text using ElevenLabs. This skill covers voice selection, audio tags, pronunciation control, text normalization, and multi-speaker dialogue.

## When to Use This Skill

- Converting blog posts or articles to audio
- Creating voiceovers for videos
- Generating podcast intros/outros
- Building conversational AI responses
- Producing audiobook chapters
- Creating voice demos or samples

## Quick Reference

### Model Selection

| Model | Best For | Latency | Quality |
|-------|----------|---------|---------|
| Eleven v3 | Expressive content, emotional range, audio tags | Medium | Highest |
| Multilingual v2 | Multiple languages, number/currency handling | Medium | High |
| Turbo v2.5 | Low-latency applications, conversational AI | Fast | Good |
| Flash v2 | Speed-critical applications | Fastest | Acceptable |

**Default choice:** Eleven v3 for most content. Multilingual v2 if you need reliable number pronunciation without preprocessing.

### Stability Settings (v3 Only)

- **Creative (0.0-0.3):** Most expressive, responds well to audio tags, may hallucinate
- **Natural (0.4-0.6):** Balanced, closest to original voice
- **Robust (0.7-1.0):** Most stable, less responsive to direction

**Default:** Natural (0.5) for most use cases.

---

## Core Techniques

### 1. Pauses

**For v2 models:** Use SSML break tags.

```text
"Hold on, let me think." <break time="1.5s" /> "Alright, I've got it."
```

Maximum pause: 3 seconds. Don't overuse. Too many break tags cause instability.

**For v3 models:** SSML breaks don't work. Use these alternatives:

- Ellipses (...) for hesitant pauses
- Dashes (-- or —) for short pauses
- `[short pause]` or `[long pause]` audio tags
- Line breaks in text

```text
"I thought about it for a while... and I realized you were right."
```

### 2. Pronunciation

**Phoneme tags (v2 models only):**

```xml
<phoneme alphabet="cmu-arpabet" ph="M AE1 D IH0 S AH0 N">Madison</phoneme>
```

Use CMU Arpabet over IPA. More consistent results.

**For v3 or when phonemes don't work:**

Write words phonetically. Use capitals for emphasis, apostrophes for syllable breaks.

- "trapezii" → "trapezIi" (emphasize the "ii")
- "Nguyen" → "Win" or "Nwin"
- "GIF" → "jiff" or "giff" depending on your preference

**Alias tags (for pronunciation dictionaries):**

```xml
<lexeme>
  <grapheme>Claughton</grapheme>
  <alias>Cloffton</alias>
</lexeme>
```

### 3. Emotion and Delivery

**Narrative context works better than hoping the AI "gets it":**

```text
"You're leaving?" she asked, her voice trembling with sadness.
```

The model reads the emotional guidance. Remove it in post-production if you don't want it in the final audio.

**For v3, use audio tags instead:**

```text
[sad] "You're leaving?"
```

---

## Eleven v3 Audio Tags

v3 introduces audio tags for emotional control. These go in square brackets before or after the text they modify.

### Voice/Emotion Tags

```text
[laughs], [laughs harder], [starts laughing], [wheezing]
[whispers]
[sighs], [exhales]
[sarcastic], [curious], [excited], [crying], [snorts], [mischievously]
[happy], [sad], [angry], [annoyed], [appalled], [thoughtful], [surprised]
[professional], [sympathetic], [reassuring], [dramatic]
```

### Sound Effect Tags

```text
[gunshot], [applause], [clapping], [explosion]
[swallows], [gulps]
[short pause], [long pause]
```

### Special Tags

```text
[strong French accent]
[strong Russian accent]
[sings]
[whispers]
```

Replace "French" or "Russian" with any accent. Results vary by voice.

### Tag Placement Examples

**Before the line:**
```text
[excited] "You won't believe what just happened!"
```

**After the line:**
```text
"I can't believe this is happening..." [sighs]
```

**Mid-sentence:**
```text
"I thought about it [long pause] and I realized you were right."
```

**Combined:**
```text
[whispers] "Don't tell anyone, but..." [giggles] "I already knew."
```

### What Works, What Doesn't

Tags must match the voice's character. A calm, meditative voice won't shout convincingly. A hyped voice won't whisper well.

**Works:**
- Subtle emotional shifts
- Laughs, sighs, pauses
- Accent shifts (if voice has range)

**Doesn't work:**
- Asking a whisper voice to shout
- Requesting music or complex sound effects
- Tags that contradict the voice's training data

---

## Text Normalization

Smaller models struggle with numbers, dates, currencies, and special formats. Fix this before sending to the API.

### Problem Inputs

| Input | Problem |
|-------|---------|
| $1,000,000 | May say "one thousand thousand dollars" |
| 555-123-4567 | May read as one big number |
| 2024-01-15 | May read digits individually |
| 9:30 AM | May stumble on format |
| example.com/path | Unpredictable URL handling |

### Solutions

**Option 1:** Use Multilingual v2. It handles these better natively.

**Option 2:** Preprocess text before sending to API.

### Normalization Reference

| Input | Normalized Output |
|-------|-------------------|
| $42.50 | forty-two dollars and fifty cents |
| £1,001.32 | one thousand and one pounds and thirty-two pence |
| 555-555-5555 | five five five, five five five, five five five five |
| 2nd | second |
| 3.14 | three point one four |
| 100% | one hundred percent |
| Dr. | Doctor |
| St. | Street (unless "St. Patrick") |
| Ctrl + Z | control z |
| 14:30 | two thirty PM |

### Python Normalization Function

```python
import inflect
import re

p = inflect.engine()

def normalize_for_tts(text: str) -> str:
    # Money
    def money_replacer(match):
        currency_map = {"$": "dollars", "£": "pounds", "€": "euros", "¥": "yen"}
        symbol, num = match.groups()
        num_clean = num.replace(',', '')
        
        if '.' in num_clean:
            dollars, cents = num_clean.split('.')
            return f"{p.number_to_words(int(dollars))} {currency_map.get(symbol, 'currency')} and {p.number_to_words(int(cents))} cents"
        return f"{p.number_to_words(int(num_clean))} {currency_map.get(symbol, 'currency')}"
    
    text = re.sub(r"([$£€¥])(\d+(?:,\d{3})*(?:\.\d{2})?)", money_replacer, text)
    
    # Phone numbers
    def phone_replacer(match):
        return ", ".join(" ".join(p.number_to_words(int(d)) for d in g) for g in match.groups())
    
    text = re.sub(r"(\d{3})-(\d{3})-(\d{4})", phone_replacer, text)
    
    return text
```

---

## Multi-Speaker Dialogue

v3 handles multiple voices in a single generation. Assign distinct voices from your library.

### Format

```text
Speaker 1: [excited] "Did you see the news?"

Speaker 2: [curious] "No, what happened?"

Speaker 1: "They announced the new feature we've been waiting for!"

Speaker 2: [surprised] "Already? I thought that was months away."
```

### Tips for Dialogue

1. **Consistent speaker labels.** Use "Speaker 1" or character names consistently.
2. **Vary emotional tags.** Don't make every line dramatic.
3. **Natural interruptions.** Use em-dashes for cut-offs: "I was just going to—"
4. **Overlapping timing.** v3 can handle speakers cutting each other off.

---

## Content-Specific Templates

### Blog Post to Audio

```text
[conversational] Today I want to talk about something that's been bugging me for a while.

WordPress caching. [sighs] It's one of those topics that sounds simple but gets complicated fast.

Here's what actually matters... [short pause] your server response time and how efficiently your pages get built. Everything else? Noise.
```

### Tutorial Narration

```text
[professional] Step one. Open your WordPress dashboard and navigate to Plugins.

[reassuring] Don't worry if your screen looks slightly different. The core layout is the same across most themes.

Click "Add New" in the top left corner. [short pause] You should see a search bar appear.
```

### Product Review

```text
[thoughtful] FlyingPress has become my go-to caching plugin. Let me explain why.

[matter-of-fact] First, it's fast. Not "marketing fast" where they cherry-pick benchmarks. Actually fast. I tested it against WP Rocket on twelve sites. FlyingPress won every time.

[honest] Now, the downsides. [sighs] Documentation is sparse. If you're the type who needs hand-holding, this might not be for you.
```

### Newsletter Read

```text
[warm] Hey, welcome to The Friday Drop. I'm Gaurav, and this is issue one fifty-two.

[excited] This week we've got some big news in the WordPress world. [short pause] Plus, I finally tested that new hosting stack I've been curious about.

Let's get into it.
```

---

## Voice Selection Guide

### For Your Content Types

| Content | Voice Characteristics | Stability |
|---------|----------------------|-----------|
| Blog posts | Conversational, warm, slight enthusiasm | Natural (0.5) |
| Tutorials | Clear, professional, patient | Natural-Robust (0.6) |
| Reviews | Honest, thoughtful, occasional skepticism | Natural (0.5) |
| Newsletter | Friendly, energetic, personal | Creative-Natural (0.4) |
| Technical docs | Neutral, clear, consistent | Robust (0.7) |

### Voice Library Collections

ElevenLabs maintains curated collections. For v3 specifically, check their "Voices for V3" collection. These are optimized for the new model's capabilities.

### Creating Custom Voices (IVC)

For instant voice clones:

1. **Emotionally diverse samples:** Include both neutral and expressive recordings
2. **Consistent audio quality:** Same microphone, same room, same distance
3. **Minimum 1 minute:** More is better, up to 10 minutes
4. **Clear speech:** No background noise, no music, no overlapping speakers

---

## Common Issues and Fixes

### Issue: Unnatural pacing

**Cause:** Voice was trained on short clips or inconsistent samples.

**Fix:** Use speed setting (0.7-1.2 range). Or rewrite text with more natural rhythm. Add pauses with ellipses.

### Issue: Wrong emphasis

**Cause:** Model doesn't understand which words matter.

**Fix:** CAPITALIZE important words. Or restructure sentence to put key info at the end.

### Issue: Pronunciation errors

**Cause:** Unusual names, technical terms, or foreign words.

**Fix:** Write phonetically, use alias tags, or create a pronunciation dictionary.

### Issue: Audio tags ignored

**Cause:** Using Robust stability, or tag contradicts voice character.

**Fix:** Lower stability to Natural or Creative. Or choose a different voice that matches the desired emotion.

### Issue: Hallucinations (random sounds, repeated words)

**Cause:** Stability too low, or text is ambiguous.

**Fix:** Increase stability. Simplify text structure. Remove conflicting emotional cues.

---

## API Integration Notes

### Basic Request Structure

```python
import requests

url = "https://api.elevenlabs.io/v1/text-to-speech/{voice_id}"

headers = {
    "xi-api-key": "your-api-key",
    "Content-Type": "application/json"
}

data = {
    "text": "[excited] This is a test of the text to speech system.",
    "model_id": "eleven_v3",
    "voice_settings": {
        "stability": 0.5,
        "similarity_boost": 0.75,
        "speed": 1.0
    }
}

response = requests.post(url, json=data, headers=headers)

with open("output.mp3", "wb") as f:
    f.write(response.content)
```

### Model IDs

- `eleven_v3` - Eleven v3 (latest)
- `eleven_multilingual_v2` - Multilingual v2
- `eleven_turbo_v2_5` - Turbo v2.5
- `eleven_flash_v2` - Flash v2

### Rate Limits

Check your plan. Free tier has strict limits. Pro plans vary by subscription level.

---

## Workflow Checklist

Before generating audio:

- [ ] Text normalized (numbers, dates, currencies spelled out if needed)
- [ ] Pronunciation checked for unusual names/terms
- [ ] Audio tags added for emotional beats (v3)
- [ ] Voice selected that matches content tone
- [ ] Stability setting appropriate for content type
- [ ] Text broken into reasonable chunks (long content)

After generating:

- [ ] Listen for pronunciation errors
- [ ] Check pacing feels natural
- [ ] Remove any spoken emotional directions if unwanted
- [ ] Trim silence at start/end
- [ ] Normalize audio levels if combining multiple clips

---

## File Output Recommendations

### For Web

- Format: MP3
- Bitrate: 128-192 kbps
- Sample rate: 44.1 kHz

### For Podcast

- Format: MP3 or M4A
- Bitrate: 192-256 kbps
- Sample rate: 44.1 kHz
- Loudness: -16 LUFS (podcast standard)

### For Video

- Format: WAV or high-bitrate MP3
- Sample rate: 48 kHz (matches video standard)
- Keep original quality for editing flexibility
