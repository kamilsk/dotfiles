package macos

// Stored preferences, not the effective values shown by System Settings.
// Keep the source mapping and value constraints together: the exporter derives
// its allowlist from this schema, without a second list of keys in Python.
#Descriptor: {
	source: {
		backend: "defaults"
		scope:   "current-user-any-host"
		domain:  string
		key:     string
	}
	#Value: bool | number | string
}

#Observation: {
	source!: {
		backend!: "defaults"
		scope!:   "current-user-any-host"
		domain!:  string
		key!:     string
	}
	({
		state!: "set"
		value!: bool | number | string
		error?: _|_
	} | {
		state!: "unset"
		value?: _|_
		error?: _|_
	} | {
		state!: "unavailable"
		value?: _|_
		error!: "read-failed" | "invalid-plist" | "timeout"
	})
}

// Some macOS versions store switches as integers. Preserve their native value.
#Flag: #Descriptor & {#Value: bool | 0 | 1}
#Number: #Descriptor & {#Value: number & >=0}
#Text: #Descriptor & {#Value: string}

#Global: #Descriptor & {source: domain: "NSGlobalDomain"}
#Dock: #Descriptor & {source: domain: "com.apple.dock"}
#Trackpad: #Descriptor & {source: domain: "com.apple.AppleMultitouchTrackpad"}
#Accessibility: #Descriptor & {source: domain: "com.apple.universalaccess"}
#Screenshot: #Descriptor & {source: domain: "com.apple.screencapture"}

// Friendly names identify stored keys. They do not assert that a particular
// macOS release still uses the key, or that it wins over managed/ByHost values.
#Settings: {
	appearance: {
		interfaceStyle: #Text & #Global & {source: key: "AppleInterfaceStyle"}
		automaticSwitching: #Flag & #Global & {source: key: "AppleInterfaceStyleSwitchesAutomatically"}
		accentColor: #Descriptor & #Global & {
			source: key: "AppleAccentColor"
			#Value: int
		}
		highlightColor: #Text & #Global & {source: key: "AppleHighlightColor"}
		scrollBars: #Text & #Global & {source: key: "AppleShowScrollBars"}
	}
	dock: {
		autoHide: #Flag & #Dock & {source: key: "autohide"}
		position: #Text & #Dock & {source: key: "orientation"}
		iconSize: #Number & #Dock & {source: key: "tilesize"}
		magnification: #Flag & #Dock & {source: key: "magnification"}
		magnifiedIconSize: #Number & #Dock & {source: key: "largesize"}
		showRecentApps: #Flag & #Dock & {source: key: "show-recents"}
		minimizeToApplication: #Flag & #Dock & {source: key: "minimize-to-application"}
		minimizeEffect: #Text & #Dock & {source: key: "mineffect"}
	}
	missionControl: {
		rearrangeSpaces: #Flag & #Dock & {source: key: "mru-spaces"}
		groupWindowsByApplication: #Flag & #Dock & {source: key: "expose-group-apps"}
	}
	keyboard: {
		// Native timing units; no conversion to a System Settings slider position.
		repeatInterval: #Number & #Global & {source: key: "KeyRepeat"}
		repeatDelay: #Number & #Global & {source: key: "InitialKeyRepeat"}
		standardFunctionKeys: #Flag & #Global & {source: key: "com.apple.keyboard.fnState"}
		automaticSpellingCorrection: #Flag & #Global & {source: key: "NSAutomaticSpellingCorrectionEnabled"}
		automaticCapitalization: #Flag & #Global & {source: key: "NSAutomaticCapitalizationEnabled"}
		automaticPeriod: #Flag & #Global & {source: key: "NSAutomaticPeriodSubstitutionEnabled"}
		smartQuotes: #Flag & #Global & {source: key: "NSAutomaticQuoteSubstitutionEnabled"}
		smartDashes: #Flag & #Global & {source: key: "NSAutomaticDashSubstitutionEnabled"}
	}
	trackpad: {
		tapToClick: #Flag & #Trackpad & {source: key: "Clicking"}
		secondaryClick: #Flag & #Trackpad & {source: key: "TrackpadRightClick"}
		threeFingerDrag: #Flag & #Trackpad & {source: key: "TrackpadThreeFingerDrag"}
	}
	scrolling: {
		naturalDirection: #Flag & #Global & {source: key: "com.apple.swipescrolldirection"}
	}
	accessibility: {
		reduceMotion: #Flag & #Accessibility & {source: key: "reduceMotion"}
		reduceTransparency: #Flag & #Accessibility & {source: key: "reduceTransparency"}
	}
	screenshots: {
		format: #Text & #Screenshot & {source: key: "type"}
		disableShadow: #Flag & #Screenshot & {source: key: "disable-shadow"}
		showThumbnail: #Flag & #Screenshot & {source: key: "show-thumbnail"}
	}
}

catalog: {
	for section, entries in #Settings {
		"\(section)": {
			for name, entry in entries {
				"\(name)": entry.source
			}
		}
	}
}

#Snapshot: {
	schemaVersion!: 1
	kind!:          "macos-preferences-snapshot"
	system!: {
		os!:      "macOS"
		version!: string & !=""
		build!:   string & !=""
	}
	// Derive required data fields without unifying the snapshot with the regular
	// catalog fields: regular constants would satisfy presence without JSON data.
	settings!: {
		for section, entries in #Settings {
			"\(section)"!: {
				for name, descriptor in entries {
					"\(name)"!: #Observation & {
						source!: {
							backend!: descriptor.source.backend
							scope!:   descriptor.source.scope
							domain!:  descriptor.source.domain
							key!:     descriptor.source.key
						}
						value?: descriptor.#Value
					}
				}
			}
		}
	}
}
