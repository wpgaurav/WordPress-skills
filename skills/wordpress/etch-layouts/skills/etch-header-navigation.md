# Etch Header & Navigation Skill

Create responsive headers with mega menus, dropdowns, and mobile navigation in Etch JSON format.

## Header Structure Overview

A complete header typically includes:
- Logo/brand area
- Primary navigation (desktop)
- Mega menu dropdowns
- Mobile menu toggle (hamburger)
- Mobile navigation drawer/overlay
- Optional: CTA button, search, user account

## Basic Header Shell

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "header",
      "attributes": {
        "class": "site-header",
        "data-header": "main"
      }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "site-header__container" }
        },
        "innerBlocks": [
          // Logo, Nav, Mobile Toggle go here
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

## Complete Patterns

### 1. Simple Header with Dropdown Navigation

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "header",
      "attributes": { "class": "site-header" }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "site-header__container" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "a",
              "attributes": {
                "href": "/",
                "class": "site-header__logo",
                "aria-label": "Home"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "img",
                  "attributes": {
                    "src": "{site.logo}",
                    "alt": "{site.name}"
                  }
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "nav",
              "attributes": {
                "class": "site-header__nav",
                "aria-label": "Primary navigation"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "ul",
                  "attributes": { "class": "nav-menu" }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/loop",
                    "attrs": {
                      "loopId": "nav",
                      "itemId": "item",
                      "indexId": "idx"
                    },
                    "innerBlocks": [
                      {
                        "blockName": "etch/element",
                        "attrs": {
                          "tag": "li",
                          "attributes": {
                            "class": "nav-menu__item {item.children.length().greater(0, \"has-dropdown\", \"\")}"
                          }
                        },
                        "innerBlocks": [
                          {
                            "blockName": "etch/element",
                            "attrs": {
                              "tag": "a",
                              "attributes": {
                                "href": "{item.url}",
                                "class": "nav-menu__link {item.class}"
                              }
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/text",
                                "attrs": { "content": "{item.label}" },
                                "innerBlocks": [],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          },
                          {
                            "blockName": "etch/condition",
                            "attrs": {
                              "conditionString": "item.children"
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/element",
                                "attrs": {
                                  "tag": "ul",
                                  "attributes": { "class": "nav-dropdown" }
                                },
                                "innerBlocks": [
                                  {
                                    "blockName": "etch/loop",
                                    "attrs": {
                                      "target": "item.children",
                                      "itemId": "child",
                                      "indexId": "childIdx"
                                    },
                                    "innerBlocks": [
                                      {
                                        "blockName": "etch/element",
                                        "attrs": {
                                          "tag": "li",
                                          "attributes": { "class": "nav-dropdown__item" }
                                        },
                                        "innerBlocks": [
                                          {
                                            "blockName": "etch/element",
                                            "attrs": {
                                              "tag": "a",
                                              "attributes": {
                                                "href": "{child.url}",
                                                "class": "nav-dropdown__link"
                                              }
                                            },
                                            "innerBlocks": [
                                              {
                                                "blockName": "etch/text",
                                                "attrs": { "content": "{child.label}" },
                                                "innerBlocks": [],
                                                "innerHTML": "",
                                                "innerContent": []
                                              }
                                            ],
                                            "innerHTML": "",
                                            "innerContent": []
                                          }
                                        ],
                                        "innerHTML": "",
                                        "innerContent": []
                                      }
                                    ],
                                    "innerHTML": "",
                                    "innerContent": []
                                  }
                                ],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          }
                        ],
                        "innerHTML": "",
                        "innerContent": []
                      }
                    ],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "a",
              "attributes": {
                "href": "/contact",
                "class": "site-header__cta btn btn--primary"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": { "content": "Get Started" },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

### 2. Header with Mega Menu

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "header",
      "attributes": { "class": "site-header site-header--mega" }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "site-header__container" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "a",
              "attributes": {
                "href": "/",
                "class": "site-header__logo"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "img",
                  "attributes": {
                    "src": "{site.logo}",
                    "alt": "{site.name}"
                  }
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "nav",
              "attributes": {
                "class": "site-header__nav",
                "aria-label": "Main navigation"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "ul",
                  "attributes": { "class": "mega-nav" }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/loop",
                    "attrs": {
                      "loopId": "nav",
                      "itemId": "item",
                      "indexId": "idx"
                    },
                    "innerBlocks": [
                      {
                        "blockName": "etch/element",
                        "attrs": {
                          "tag": "li",
                          "attributes": {
                            "class": "mega-nav__item {item.mega.toBool().equal(true, \"has-mega\", \"\")}"
                          }
                        },
                        "innerBlocks": [
                          {
                            "blockName": "etch/element",
                            "attrs": {
                              "tag": "a",
                              "attributes": {
                                "href": "{item.url}",
                                "class": "mega-nav__link"
                              }
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/text",
                                "attrs": { "content": "{item.label}" },
                                "innerBlocks": [],
                                "innerHTML": "",
                                "innerContent": []
                              },
                              {
                                "blockName": "etch/condition",
                                "attrs": {
                                  "conditionString": "item.children"
                                },
                                "innerBlocks": [
                                  {
                                    "blockName": "etch/raw-html",
                                    "attrs": {
                                      "content": "<svg class=\"mega-nav__chevron\" width=\"12\" height=\"12\" viewBox=\"0 0 12 12\" fill=\"none\"><path d=\"M3 4.5L6 7.5L9 4.5\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/></svg>"
                                    },
                                    "innerBlocks": [],
                                    "innerHTML": "",
                                    "innerContent": []
                                  }
                                ],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          },
                          {
                            "blockName": "etch/condition",
                            "attrs": {
                              "conditionString": "item.mega"
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/element",
                                "attrs": {
                                  "tag": "div",
                                  "attributes": { "class": "mega-panel" }
                                },
                                "innerBlocks": [
                                  {
                                    "blockName": "etch/element",
                                    "attrs": {
                                      "tag": "div",
                                      "attributes": { "class": "mega-panel__container" }
                                    },
                                    "innerBlocks": [
                                      {
                                        "blockName": "etch/loop",
                                        "attrs": {
                                          "target": "item.columns",
                                          "itemId": "column",
                                          "indexId": "colIdx"
                                        },
                                        "innerBlocks": [
                                          {
                                            "blockName": "etch/element",
                                            "attrs": {
                                              "tag": "div",
                                              "attributes": { "class": "mega-panel__column" }
                                            },
                                            "innerBlocks": [
                                              {
                                                "blockName": "etch/condition",
                                                "attrs": {
                                                  "conditionString": "column.title"
                                                },
                                                "innerBlocks": [
                                                  {
                                                    "blockName": "etch/element",
                                                    "attrs": {
                                                      "tag": "h3",
                                                      "attributes": { "class": "mega-panel__title" }
                                                    },
                                                    "innerBlocks": [
                                                      {
                                                        "blockName": "etch/text",
                                                        "attrs": { "content": "{column.title}" },
                                                        "innerBlocks": [],
                                                        "innerHTML": "",
                                                        "innerContent": []
                                                      }
                                                    ],
                                                    "innerHTML": "",
                                                    "innerContent": []
                                                  }
                                                ],
                                                "innerHTML": "",
                                                "innerContent": []
                                              },
                                              {
                                                "blockName": "etch/element",
                                                "attrs": {
                                                  "tag": "ul",
                                                  "attributes": { "class": "mega-panel__links" }
                                                },
                                                "innerBlocks": [
                                                  {
                                                    "blockName": "etch/loop",
                                                    "attrs": {
                                                      "target": "column.links",
                                                      "itemId": "link",
                                                      "indexId": "linkIdx"
                                                    },
                                                    "innerBlocks": [
                                                      {
                                                        "blockName": "etch/element",
                                                        "attrs": {
                                                          "tag": "li",
                                                          "attributes": {}
                                                        },
                                                        "innerBlocks": [
                                                          {
                                                            "blockName": "etch/element",
                                                            "attrs": {
                                                              "tag": "a",
                                                              "attributes": {
                                                                "href": "{link.url}",
                                                                "class": "mega-panel__link"
                                                              }
                                                            },
                                                            "innerBlocks": [
                                                              {
                                                                "blockName": "etch/condition",
                                                                "attrs": {
                                                                  "conditionString": "link.icon"
                                                                },
                                                                "innerBlocks": [
                                                                  {
                                                                    "blockName": "etch/element",
                                                                    "attrs": {
                                                                      "tag": "span",
                                                                      "attributes": { "class": "mega-panel__icon" }
                                                                    },
                                                                    "innerBlocks": [
                                                                      {
                                                                        "blockName": "etch/raw-html",
                                                                        "attrs": { "content": "{link.icon}" },
                                                                        "innerBlocks": [],
                                                                        "innerHTML": "",
                                                                        "innerContent": []
                                                                      }
                                                                    ],
                                                                    "innerHTML": "",
                                                                    "innerContent": []
                                                                  }
                                                                ],
                                                                "innerHTML": "",
                                                                "innerContent": []
                                                              },
                                                              {
                                                                "blockName": "etch/element",
                                                                "attrs": {
                                                                  "tag": "span",
                                                                  "attributes": { "class": "mega-panel__link-content" }
                                                                },
                                                                "innerBlocks": [
                                                                  {
                                                                    "blockName": "etch/element",
                                                                    "attrs": {
                                                                      "tag": "span",
                                                                      "attributes": { "class": "mega-panel__link-label" }
                                                                    },
                                                                    "innerBlocks": [
                                                                      {
                                                                        "blockName": "etch/text",
                                                                        "attrs": { "content": "{link.label}" },
                                                                        "innerBlocks": [],
                                                                        "innerHTML": "",
                                                                        "innerContent": []
                                                                      }
                                                                    ],
                                                                    "innerHTML": "",
                                                                    "innerContent": []
                                                                  },
                                                                  {
                                                                    "blockName": "etch/condition",
                                                                    "attrs": {
                                                                      "conditionString": "link.description"
                                                                    },
                                                                    "innerBlocks": [
                                                                      {
                                                                        "blockName": "etch/element",
                                                                        "attrs": {
                                                                          "tag": "span",
                                                                          "attributes": { "class": "mega-panel__link-desc" }
                                                                        },
                                                                        "innerBlocks": [
                                                                          {
                                                                            "blockName": "etch/text",
                                                                            "attrs": { "content": "{link.description}" },
                                                                            "innerBlocks": [],
                                                                            "innerHTML": "",
                                                                            "innerContent": []
                                                                          }
                                                                        ],
                                                                        "innerHTML": "",
                                                                        "innerContent": []
                                                                      }
                                                                    ],
                                                                    "innerHTML": "",
                                                                    "innerContent": []
                                                                  }
                                                                ],
                                                                "innerHTML": "",
                                                                "innerContent": []
                                                              }
                                                            ],
                                                            "innerHTML": "",
                                                            "innerContent": []
                                                          }
                                                        ],
                                                        "innerHTML": "",
                                                        "innerContent": []
                                                      }
                                                    ],
                                                    "innerHTML": "",
                                                    "innerContent": []
                                                  }
                                                ],
                                                "innerHTML": "",
                                                "innerContent": []
                                              }
                                            ],
                                            "innerHTML": "",
                                            "innerContent": []
                                          }
                                        ],
                                        "innerHTML": "",
                                        "innerContent": []
                                      },
                                      {
                                        "blockName": "etch/condition",
                                        "attrs": {
                                          "conditionString": "item.featured"
                                        },
                                        "innerBlocks": [
                                          {
                                            "blockName": "etch/element",
                                            "attrs": {
                                              "tag": "div",
                                              "attributes": { "class": "mega-panel__featured" }
                                            },
                                            "innerBlocks": [
                                              {
                                                "blockName": "etch/element",
                                                "attrs": {
                                                  "tag": "a",
                                                  "attributes": {
                                                    "href": "{item.featured.url}",
                                                    "class": "mega-panel__featured-card"
                                                  }
                                                },
                                                "innerBlocks": [
                                                  {
                                                    "blockName": "etch/element",
                                                    "attrs": {
                                                      "tag": "img",
                                                      "attributes": {
                                                        "src": "{item.featured.image}",
                                                        "alt": "{item.featured.title}"
                                                      }
                                                    },
                                                    "innerBlocks": [],
                                                    "innerHTML": "",
                                                    "innerContent": []
                                                  },
                                                  {
                                                    "blockName": "etch/element",
                                                    "attrs": {
                                                      "tag": "span",
                                                      "attributes": { "class": "mega-panel__featured-title" }
                                                    },
                                                    "innerBlocks": [
                                                      {
                                                        "blockName": "etch/text",
                                                        "attrs": { "content": "{item.featured.title}" },
                                                        "innerBlocks": [],
                                                        "innerHTML": "",
                                                        "innerContent": []
                                                      }
                                                    ],
                                                    "innerHTML": "",
                                                    "innerContent": []
                                                  }
                                                ],
                                                "innerHTML": "",
                                                "innerContent": []
                                              }
                                            ],
                                            "innerHTML": "",
                                            "innerContent": []
                                          }
                                        ],
                                        "innerHTML": "",
                                        "innerContent": []
                                      }
                                    ],
                                    "innerHTML": "",
                                    "innerContent": []
                                  }
                                ],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          },
                          {
                            "blockName": "etch/condition",
                            "attrs": {
                              "conditionString": "!item.mega && item.children"
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/element",
                                "attrs": {
                                  "tag": "ul",
                                  "attributes": { "class": "mega-nav__dropdown" }
                                },
                                "innerBlocks": [
                                  {
                                    "blockName": "etch/loop",
                                    "attrs": {
                                      "target": "item.children",
                                      "itemId": "child",
                                      "indexId": "childIdx"
                                    },
                                    "innerBlocks": [
                                      {
                                        "blockName": "etch/element",
                                        "attrs": {
                                          "tag": "li",
                                          "attributes": {}
                                        },
                                        "innerBlocks": [
                                          {
                                            "blockName": "etch/element",
                                            "attrs": {
                                              "tag": "a",
                                              "attributes": { "href": "{child.url}" }
                                            },
                                            "innerBlocks": [
                                              {
                                                "blockName": "etch/text",
                                                "attrs": { "content": "{child.label}" },
                                                "innerBlocks": [],
                                                "innerHTML": "",
                                                "innerContent": []
                                              }
                                            ],
                                            "innerHTML": "",
                                            "innerContent": []
                                          }
                                        ],
                                        "innerHTML": "",
                                        "innerContent": []
                                      }
                                    ],
                                    "innerHTML": "",
                                    "innerContent": []
                                  }
                                ],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          }
                        ],
                        "innerHTML": "",
                        "innerContent": []
                      }
                    ],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "div",
              "attributes": { "class": "site-header__actions" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "a",
                  "attributes": {
                    "href": "/contact",
                    "class": "btn btn--primary"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "content": "Contact Us" },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

### 3. Mobile Menu Toggle (Hamburger Button)

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "button",
    "attributes": {
      "class": "mobile-toggle",
      "type": "button",
      "aria-label": "Toggle menu",
      "aria-expanded": "false",
      "aria-controls": "mobile-menu",
      "data-toggle": "mobile-menu"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "mobile-toggle__bar" }
      },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    },
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "mobile-toggle__bar" }
      },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    },
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "mobile-toggle__bar" }
      },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    }
  ],
  "innerHTML": "",
  "innerContent": []
}
```

### 4. Mobile Menu Drawer

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "div",
    "attributes": {
      "class": "mobile-menu",
      "id": "mobile-menu",
      "aria-hidden": "true",
      "data-mobile-menu": ""
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "div",
        "attributes": { "class": "mobile-menu__overlay" }
      },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    },
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "div",
        "attributes": { "class": "mobile-menu__drawer" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "div",
            "attributes": { "class": "mobile-menu__header" }
          },
          "innerBlocks": [
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "a",
                "attributes": {
                  "href": "/",
                  "class": "mobile-menu__logo"
                }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/element",
                  "attrs": {
                    "tag": "img",
                    "attributes": {
                      "src": "{site.logo}",
                      "alt": "{site.name}"
                    }
                  },
                  "innerBlocks": [],
                  "innerHTML": "",
                  "innerContent": []
                }
              ],
              "innerHTML": "",
              "innerContent": []
            },
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "button",
                "attributes": {
                  "class": "mobile-menu__close",
                  "type": "button",
                  "aria-label": "Close menu",
                  "data-close": "mobile-menu"
                }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/raw-html",
                  "attrs": {
                    "content": "<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"><path d=\"M18 6L6 18M6 6l12 12\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/></svg>"
                  },
                  "innerBlocks": [],
                  "innerHTML": "",
                  "innerContent": []
                }
              ],
              "innerHTML": "",
              "innerContent": []
            }
          ],
          "innerHTML": "",
          "innerContent": []
        },
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "nav",
            "attributes": { "class": "mobile-menu__nav" }
          },
          "innerBlocks": [
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "ul",
                "attributes": { "class": "mobile-nav" }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/loop",
                  "attrs": {
                    "loopId": "nav",
                    "itemId": "item",
                    "indexId": "idx"
                  },
                  "innerBlocks": [
                    {
                      "blockName": "etch/element",
                      "attrs": {
                        "tag": "li",
                        "attributes": {
                          "class": "mobile-nav__item {item.children.length().greater(0, \"has-submenu\", \"\")}"
                        }
                      },
                      "innerBlocks": [
                        {
                          "blockName": "etch/element",
                          "attrs": {
                            "tag": "div",
                            "attributes": { "class": "mobile-nav__item-header" }
                          },
                          "innerBlocks": [
                            {
                              "blockName": "etch/element",
                              "attrs": {
                                "tag": "a",
                                "attributes": {
                                  "href": "{item.url}",
                                  "class": "mobile-nav__link"
                                }
                              },
                              "innerBlocks": [
                                {
                                  "blockName": "etch/text",
                                  "attrs": { "content": "{item.label}" },
                                  "innerBlocks": [],
                                  "innerHTML": "",
                                  "innerContent": []
                                }
                              ],
                              "innerHTML": "",
                              "innerContent": []
                            },
                            {
                              "blockName": "etch/condition",
                              "attrs": {
                                "conditionString": "item.children"
                              },
                              "innerBlocks": [
                                {
                                  "blockName": "etch/element",
                                  "attrs": {
                                    "tag": "button",
                                    "attributes": {
                                      "class": "mobile-nav__toggle",
                                      "type": "button",
                                      "aria-expanded": "false",
                                      "data-submenu-toggle": ""
                                    }
                                  },
                                  "innerBlocks": [
                                    {
                                      "blockName": "etch/raw-html",
                                      "attrs": {
                                        "content": "<svg width=\"16\" height=\"16\" viewBox=\"0 0 16 16\" fill=\"none\"><path d=\"M4 6l4 4 4-4\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/></svg>"
                                      },
                                      "innerBlocks": [],
                                      "innerHTML": "",
                                      "innerContent": []
                                    }
                                  ],
                                  "innerHTML": "",
                                  "innerContent": []
                                }
                              ],
                              "innerHTML": "",
                              "innerContent": []
                            }
                          ],
                          "innerHTML": "",
                          "innerContent": []
                        },
                        {
                          "blockName": "etch/condition",
                          "attrs": {
                            "conditionString": "item.children"
                          },
                          "innerBlocks": [
                            {
                              "blockName": "etch/element",
                              "attrs": {
                                "tag": "ul",
                                "attributes": {
                                  "class": "mobile-nav__submenu",
                                  "data-submenu": ""
                                }
                              },
                              "innerBlocks": [
                                {
                                  "blockName": "etch/loop",
                                  "attrs": {
                                    "target": "item.children",
                                    "itemId": "child",
                                    "indexId": "childIdx"
                                  },
                                  "innerBlocks": [
                                    {
                                      "blockName": "etch/element",
                                      "attrs": {
                                        "tag": "li",
                                        "attributes": { "class": "mobile-nav__submenu-item" }
                                      },
                                      "innerBlocks": [
                                        {
                                          "blockName": "etch/element",
                                          "attrs": {
                                            "tag": "a",
                                            "attributes": {
                                              "href": "{child.url}",
                                              "class": "mobile-nav__submenu-link"
                                            }
                                          },
                                          "innerBlocks": [
                                            {
                                              "blockName": "etch/text",
                                              "attrs": { "content": "{child.label}" },
                                              "innerBlocks": [],
                                              "innerHTML": "",
                                              "innerContent": []
                                            }
                                          ],
                                          "innerHTML": "",
                                          "innerContent": []
                                        }
                                      ],
                                      "innerHTML": "",
                                      "innerContent": []
                                    }
                                  ],
                                  "innerHTML": "",
                                  "innerContent": []
                                }
                              ],
                              "innerHTML": "",
                              "innerContent": []
                            }
                          ],
                          "innerHTML": "",
                          "innerContent": []
                        }
                      ],
                      "innerHTML": "",
                      "innerContent": []
                    }
                  ],
                  "innerHTML": "",
                  "innerContent": []
                }
              ],
              "innerHTML": "",
              "innerContent": []
            }
          ],
          "innerHTML": "",
          "innerContent": []
        },
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "div",
            "attributes": { "class": "mobile-menu__footer" }
          },
          "innerBlocks": [
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "a",
                "attributes": {
                  "href": "/contact",
                  "class": "btn btn--primary btn--full"
                }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/text",
                  "attrs": { "content": "Contact Us" },
                  "innerBlocks": [],
                  "innerHTML": "",
                  "innerContent": []
                }
              ],
              "innerHTML": "",
              "innerContent": []
            }
          ],
          "innerHTML": "",
          "innerContent": []
        }
      ],
      "innerHTML": "",
      "innerContent": []
    }
  ],
  "innerHTML": "",
  "innerContent": []
}
```

### 5. Complete Header with Mobile Support

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "header",
      "attributes": {
        "class": "site-header",
        "data-header": ""
      }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "site-header__container" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "a",
              "attributes": {
                "href": "/",
                "class": "site-header__logo"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "img",
                  "attributes": {
                    "src": "{site.logo}",
                    "alt": "{site.name}"
                  }
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "nav",
              "attributes": {
                "class": "site-header__nav site-header__nav--desktop",
                "aria-label": "Main navigation"
              }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "ul",
                  "attributes": { "class": "nav-menu" }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/loop",
                    "attrs": {
                      "loopId": "nav",
                      "itemId": "item",
                      "indexId": "idx"
                    },
                    "innerBlocks": [
                      {
                        "blockName": "etch/element",
                        "attrs": {
                          "tag": "li",
                          "attributes": { "class": "nav-menu__item" }
                        },
                        "innerBlocks": [
                          {
                            "blockName": "etch/element",
                            "attrs": {
                              "tag": "a",
                              "attributes": {
                                "href": "{item.url}",
                                "class": "nav-menu__link {item.class}"
                              }
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/text",
                                "attrs": { "content": "{item.label}" },
                                "innerBlocks": [],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          },
                          {
                            "blockName": "etch/condition",
                            "attrs": {
                              "conditionString": "item.children"
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/element",
                                "attrs": {
                                  "tag": "ul",
                                  "attributes": { "class": "nav-dropdown" }
                                },
                                "innerBlocks": [
                                  {
                                    "blockName": "etch/loop",
                                    "attrs": {
                                      "target": "item.children",
                                      "itemId": "child",
                                      "indexId": "childIdx"
                                    },
                                    "innerBlocks": [
                                      {
                                        "blockName": "etch/element",
                                        "attrs": {
                                          "tag": "li",
                                          "attributes": {}
                                        },
                                        "innerBlocks": [
                                          {
                                            "blockName": "etch/element",
                                            "attrs": {
                                              "tag": "a",
                                              "attributes": { "href": "{child.url}" }
                                            },
                                            "innerBlocks": [
                                              {
                                                "blockName": "etch/text",
                                                "attrs": { "content": "{child.label}" },
                                                "innerBlocks": [],
                                                "innerHTML": "",
                                                "innerContent": []
                                              }
                                            ],
                                            "innerHTML": "",
                                            "innerContent": []
                                          }
                                        ],
                                        "innerHTML": "",
                                        "innerContent": []
                                      }
                                    ],
                                    "innerHTML": "",
                                    "innerContent": []
                                  }
                                ],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          }
                        ],
                        "innerHTML": "",
                        "innerContent": []
                      }
                    ],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "div",
              "attributes": { "class": "site-header__actions" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "a",
                  "attributes": {
                    "href": "/contact",
                    "class": "btn btn--primary site-header__cta"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "content": "Get Started" },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              },
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "button",
                  "attributes": {
                    "class": "mobile-toggle",
                    "type": "button",
                    "aria-label": "Open menu",
                    "aria-expanded": "false",
                    "data-toggle": "mobile-menu"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/element",
                    "attrs": {
                      "tag": "span",
                      "attributes": { "class": "mobile-toggle__bar" }
                    },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  },
                  {
                    "blockName": "etch/element",
                    "attrs": {
                      "tag": "span",
                      "attributes": { "class": "mobile-toggle__bar" }
                    },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  },
                  {
                    "blockName": "etch/element",
                    "attrs": {
                      "tag": "span",
                      "attributes": { "class": "mobile-toggle__bar" }
                    },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  },
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "div",
      "attributes": {
        "class": "mobile-menu",
        "id": "mobile-menu",
        "aria-hidden": "true"
      }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "mobile-menu__overlay" }
        },
        "innerBlocks": [],
        "innerHTML": "",
        "innerContent": []
      },
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "mobile-menu__drawer" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "div",
              "attributes": { "class": "mobile-menu__header" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "button",
                  "attributes": {
                    "class": "mobile-menu__close",
                    "type": "button",
                    "aria-label": "Close menu"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/raw-html",
                    "attrs": {
                      "content": "<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"><path d=\"M18 6L6 18M6 6l12 12\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/></svg>"
                    },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "nav",
              "attributes": { "class": "mobile-menu__nav" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "ul",
                  "attributes": { "class": "mobile-nav" }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/loop",
                    "attrs": {
                      "loopId": "nav",
                      "itemId": "item",
                      "indexId": "idx"
                    },
                    "innerBlocks": [
                      {
                        "blockName": "etch/element",
                        "attrs": {
                          "tag": "li",
                          "attributes": { "class": "mobile-nav__item" }
                        },
                        "innerBlocks": [
                          {
                            "blockName": "etch/element",
                            "attrs": {
                              "tag": "a",
                              "attributes": {
                                "href": "{item.url}",
                                "class": "mobile-nav__link"
                              }
                            },
                            "innerBlocks": [
                              {
                                "blockName": "etch/text",
                                "attrs": { "content": "{item.label}" },
                                "innerBlocks": [],
                                "innerHTML": "",
                                "innerContent": []
                              }
                            ],
                            "innerHTML": "",
                            "innerContent": []
                          }
                        ],
                        "innerHTML": "",
                        "innerContent": []
                      }
                    ],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "div",
              "attributes": { "class": "mobile-menu__footer" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "tag": "a",
                  "attributes": {
                    "href": "/contact",
                    "class": "btn btn--primary btn--full"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "content": "Get Started" },
                    "innerBlocks": [],
                    "innerHTML": "",
                    "innerContent": []
                  }
                ],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

## Navigation Data Structure

For the `nav` loop preset, structure your data like this:

```json
[
  {
    "label": "Home",
    "url": "/"
  },
  {
    "label": "Products",
    "url": "/products",
    "mega": true,
    "columns": [
      {
        "title": "Categories",
        "links": [
          { "label": "Software", "url": "/products/software", "description": "Digital tools" },
          { "label": "Hardware", "url": "/products/hardware", "description": "Physical devices" }
        ]
      },
      {
        "title": "Resources",
        "links": [
          { "label": "Documentation", "url": "/docs" },
          { "label": "Tutorials", "url": "/tutorials" }
        ]
      }
    ],
    "featured": {
      "title": "New Release",
      "url": "/products/new",
      "image": "/images/featured.jpg"
    }
  },
  {
    "label": "Services",
    "url": "/services",
    "children": [
      { "label": "Consulting", "url": "/services/consulting" },
      { "label": "Development", "url": "/services/development" },
      { "label": "Support", "url": "/services/support" }
    ]
  },
  {
    "label": "About",
    "url": "/about"
  },
  {
    "label": "Contact",
    "url": "/contact",
    "class": "btn--primary"
  }
]
```

## CSS Class Reference

### Header Classes
- `.site-header` - Main header wrapper
- `.site-header__container` - Inner container
- `.site-header__logo` - Logo link
- `.site-header__nav` - Navigation wrapper
- `.site-header__nav--desktop` - Desktop-only nav
- `.site-header__actions` - Right-side actions
- `.site-header__cta` - CTA button

### Desktop Navigation
- `.nav-menu` - Main navigation list
- `.nav-menu__item` - Navigation item
- `.nav-menu__link` - Navigation link
- `.nav-dropdown` - Dropdown menu
- `.has-dropdown` - Item with dropdown

### Mega Menu
- `.mega-nav` - Mega navigation list
- `.mega-nav__item` - Mega nav item
- `.mega-nav__link` - Mega nav link
- `.has-mega` - Item with mega panel
- `.mega-panel` - Mega menu panel
- `.mega-panel__container` - Panel inner container
- `.mega-panel__column` - Column in mega panel
- `.mega-panel__title` - Column title
- `.mega-panel__links` - Links list
- `.mega-panel__link` - Individual link
- `.mega-panel__icon` - Link icon
- `.mega-panel__link-label` - Link text
- `.mega-panel__link-desc` - Link description
- `.mega-panel__featured` - Featured content area

### Mobile Toggle
- `.mobile-toggle` - Hamburger button
- `.mobile-toggle__bar` - Hamburger lines
- `.is-active` - Active state modifier

### Mobile Menu
- `.mobile-menu` - Mobile menu wrapper
- `.mobile-menu__overlay` - Background overlay
- `.mobile-menu__drawer` - Slide-in panel
- `.mobile-menu__header` - Drawer header
- `.mobile-menu__close` - Close button
- `.mobile-menu__nav` - Navigation wrapper
- `.mobile-menu__footer` - Footer with CTA
- `.is-open` - Open state modifier

### Mobile Navigation
- `.mobile-nav` - Mobile nav list
- `.mobile-nav__item` - Nav item
- `.mobile-nav__item-header` - Item header (link + toggle)
- `.mobile-nav__link` - Nav link
- `.mobile-nav__toggle` - Submenu toggle button
- `.mobile-nav__submenu` - Submenu list
- `.mobile-nav__submenu-item` - Submenu item
- `.mobile-nav__submenu-link` - Submenu link
- `.has-submenu` - Item with submenu
- `.is-expanded` - Expanded submenu state

## Accessibility Attributes

Always include these for proper accessibility:

| Attribute | Purpose |
|-----------|---------|
| `aria-label` | Describes the navigation purpose |
| `aria-expanded` | Toggle state for dropdowns/menus |
| `aria-controls` | Links toggle to its target |
| `aria-hidden` | Hides content from screen readers |
| `role="navigation"` | (optional, `<nav>` is semantic) |

## Output Requirements

1. Output ONLY valid JSON
2. JSON must be an array
3. Include all accessibility attributes
4. Use semantic HTML tags (`header`, `nav`, `button`)
5. Use data attributes for JavaScript hooks
6. Keep class naming consistent (BEM recommended)
