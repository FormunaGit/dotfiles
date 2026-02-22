{ ... }:
{
  programs.noctalia.settings = {
    appLauncher = {
      autoPasteClipboard = false;
      clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
      clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
      clipboardWrapText = true;
      customLaunchPrefix = "";
      customLaunchPrefixEnabled = false;
      enableClipPreview = true;
      enableClipboardHistory = true;
      enableSettingsSearch = true;
      enableWindowsSearch = true;
      iconMode = "native";
      ignoreMouseInput = false;
      pinnedApps = [

      ];
      position = "center";
      screenshotAnnotationTool = "";
      showCategories = true;
      showIconBackground = false;
      sortByMostUsed = true;
      terminalCommand = "alacritty -e";
      useApp2Unit = false;
      viewMode = "list";
    };
    audio = {
      cavaFrameRate = 60;
      mprisBlacklist = [

      ];
      preferredPlayer = "";
      visualizerType = "wave";
      volumeFeedback = false;
      volumeOverdrive = false;
      volumeStep = 5;
    };
    bar = {
      autoHideDelay = 500;
      autoShowDelay = 150;
      backgroundOpacity = 1;
      barType = "simple";
      capsuleColorKey = "none";
      capsuleOpacity = 1;
      density = "default";
      displayMode = "always_visible";
      floating = false;
      frameRadius = 4;
      frameThickness = 8;
      hideOnOverview = false;
      marginHorizontal = 4;
      marginVertical = 4;
      monitors = [

      ];
      outerCorners = false;
      position = "bottom";
      screenOverrides = [

      ];
      showCapsule = true;
      showOutline = false;
      useSeparateOpacity = false;
      widgets = {
        center = [
          {
            colorizeIcons = false;
            hideMode = "hidden";
            id = "ActiveWindow";
            maxWidth = 145;
            scrollingMode = "hover";
            showIcon = true;
            textColor = "none";
            useFixedWidth = false;
          }
          {
            defaultSettings = {
              activeColor = "primary";
              hideInactive = false;
              inactiveColor = "none";
              removeMargins = false;
            };
            id = "plugin:privacy-indicator";
          }
          {
            compactMode = false;
            compactShowAlbumArt = true;
            compactShowVisualizer = false;
            hideMode = "hidden";
            hideWhenIdle = false;
            id = "MediaMini";
            maxWidth = 145;
            panelShowAlbumArt = true;
            panelShowVisualizer = true;
            scrollingMode = "hover";
            showAlbumArt = true;
            showArtistFirst = true;
            showProgressRing = true;
            showVisualizer = true;
            textColor = "none";
            useFixedWidth = false;
            visualizerType = "linear";
          }
        ];
        left = [
          {
            characterCount = 2;
            colorizeIcons = false;
            emptyColor = "secondary";
            enableScrollWheel = true;
            focusedColor = "primary";
            followFocusedScreen = false;
            groupedBorderOpacity = 1;
            hideUnoccupied = false;
            iconScale = 0.8;
            id = "Workspace";
            labelMode = "name";
            occupiedColor = "secondary";
            pillSize = 0.7;
            reverseScroll = false;
            showApplications = true;
            showBadge = true;
            showLabelsOnlyWhenOccupied = true;
            unfocusedIconsOpacity = 1;
          }
          {
            compactMode = true;
            diskPath = "/";
            iconColor = "none";
            id = "SystemMonitor";
            showCpuFreq = false;
            showCpuTemp = true;
            showCpuUsage = true;
            showDiskAvailable = false;
            showDiskUsage = false;
            showDiskUsageAsPercent = false;
            showGpuTemp = false;
            showLoadAverage = false;
            showMemoryAsPercent = false;
            showMemoryUsage = true;
            showNetworkStats = false;
            showSwapUsage = false;
            textColor = "none";
            useMonospaceFont = true;
          }
        ];
        right = [
          {
            blacklist = [

            ];
            chevronColor = "none";
            colorizeIcons = false;
            drawerEnabled = false;
            hidePassive = false;
            id = "Tray";
            pinned = [

            ];
          }
          {
            hideWhenZero = false;
            hideWhenZeroUnread = false;
            iconColor = "none";
            id = "NotificationHistory";
            showUnreadBadge = true;
            unreadBadgeColor = "primary";
          }
          {
            displayMode = "onhover";
            iconColor = "none";
            id = "VPN";
            textColor = "none";
          }
          {
            displayMode = "onhover";
            iconColor = "none";
            id = "Volume";
            middleClickCommand = "pwvucontrol || pavucontrol";
            textColor = "none";
          }
          {
            displayMode = "onhover";
            iconColor = "none";
            id = "Brightness";
            textColor = "none";
          }
          {
            icon = "rocket";
            iconColor = "none";
            id = "Launcher";
          }
          {
            colorizeDistroLogo = false;
            colorizeSystemIcon = "none";
            customIconPath = "";
            enableColorization = false;
            icon = "noctalia";
            id = "ControlCenter";
            useDistroLogo = false;
          }
          {
            clockColor = "none";
            customFont = "";
            formatHorizontal = "h:mm AP ddd, MMM dd";
            formatVertical = "HH mm - dd MM";
            id = "Clock";
            tooltipFormat = "HH:mm ddd, MMM dd";
            useCustomFont = false;
          }
          {
            defaultSettings = {
              autoHeight = true;
              cheatsheetData = [

              ];
              columnCount = 3;
              detectedCompositor = "";
              hyprlandConfigPath = "~/.config/hypr/hyprland.conf";
              modKeyVariable = "$mod";
              niriConfigPath = "~/.config/niri/config.kdl";
              windowHeight = 0;
              windowWidth = 1400;
            };
            id = "plugin:keybind-cheatsheet";
          }
          {
            defaultSettings = {
            };
            id = "plugin:kde-connect";
          }
        ];
      };
    };
    brightness = {
      brightnessStep = 5;
      enableDdcSupport = false;
      enforceMinimum = true;
    };
    calendar = {
      cards = [
        {
          enabled = true;
          id = "calendar-header-card";
        }
        {
          enabled = true;
          id = "calendar-month-card";
        }
        {
          enabled = true;
          id = "weather-card";
        }
      ];
    };
    colorSchemes = {
      darkMode = true;
      generationMethod = "dysfunctional";
      manualSunrise = "06:30";
      manualSunset = "18:30";
      monitorForColors = "";
      predefinedScheme = "Gruvbox";
      schedulingMode = "off";
      useWallpaperColors = false;
    };
    controlCenter = {
      cards = [
        {
          enabled = true;
          id = "profile-card";
        }
        {
          enabled = true;
          id = "shortcuts-card";
        }
        {
          enabled = true;
          id = "audio-card";
        }
        {
          enabled = false;
          id = "brightness-card";
        }
        {
          enabled = true;
          id = "weather-card";
        }
        {
          enabled = true;
          id = "media-sysmon-card";
        }
      ];
      diskPath = "/";
      position = "close_to_bar_button";
      shortcuts = {
        left = [
          {
            id = "Network";
          }
          {
            id = "Bluetooth";
          }
          {
            id = "WallpaperSelector";
          }
          {
            id = "NoctaliaPerformance";
          }
        ];
        right = [
          {
            id = "Notifications";
          }
          {
            id = "PowerProfile";
          }
          {
            id = "KeepAwake";
          }
          {
            id = "NightLight";
          }
        ];
      };
    };
    desktopWidgets = {
      enabled = true;
      gridSnap = false;
      monitorWidgets = [
        {
          name = "HDMI-A-1";
          widgets = [
            {
              clockColor = "none";
              clockStyle = "minimal";
              customFont = "MonaspiceKr Nerd Font Mono";
              format = "h:mm AP\\nd MMMM yyyy";
              id = "Clock";
              roundedCorners = true;
              scale = 1;
              showBackground = true;
              useCustomFont = true;
              x = 23;
              y = 55;
            }
            {
              diskPath = "/home/formuna/Data";
              id = "SystemStat";
              layout = "bottom";
              roundedCorners = true;
              scale = 1;
              showBackground = true;
              statType = "CPU";
              x = 38;
              y = 862;
            }
            {
              defaultSettings = {
                barWidth = 0.6;
                bloomIntensity = 0.5;
                customPrimaryColor = "#6750A4";
                customSecondaryColor = "#625B71";
                fadeWhenIdle = false;
                innerDiameter = 0.7;
                ringOpacity = 0.8;
                rotationSpeed = 0.5;
                sensitivity = 1.5;
                useCustomColors = false;
                visualizationMode = 3;
                waveThickness = 1;
              };
              id = "plugin:fancy-audiovisualizer";
              showBackground = true;
              x = 1291;
              y = 360;
            }
          ];
        }
      ];
    };
    dock = {
      animationSpeed = 1;
      backgroundOpacity = 1;
      colorizeIcons = true;
      deadOpacity = 0.6;
      displayMode = "auto_hide";
      enabled = true;
      floatingRatio = 1;
      inactiveIndicators = false;
      monitors = [

      ];
      onlySameOutput = true;
      pinnedApps = [

      ];
      pinnedStatic = false;
      position = "bottom";
      size = 1;
    };
    general = {
      allowPanelsOnScreenWithoutBar = true;
      allowPasswordWithFprintd = false;
      animationDisabled = false;
      animationSpeed = 1.5;
      autoStartAuth = false;
      avatarImage = "/home/formuna/Downloads/formuna.png";
      boxRadiusRatio = 1;
      clockFormat = "h:mm AP ";
      clockStyle = "custom";
      compactLockScreen = false;
      dimmerOpacity = 0.61;
      enableLockScreenCountdown = true;
      enableShadows = true;
      forceBlackScreenCorners = false;
      iRadiusRatio = 0.2;
      language = "";
      lockOnSuspend = true;
      lockScreenCountdownDuration = 10000;
      radiusRatio = 0.4;
      scaleRatio = 0.8;
      screenRadiusRatio = 1;
      shadowDirection = "center";
      shadowOffsetX = 0;
      shadowOffsetY = 0;
      showChangelogOnStartup = true;
      showHibernateOnLockScreen = false;
      showScreenCorners = false;
      showSessionButtonsOnLockScreen = true;
      telemetryEnabled = true;
    };
    hooks = {
      darkModeChange = "";
      enabled = false;
      performanceModeDisabled = "";
      performanceModeEnabled = "";
      screenLock = "";
      screenUnlock = "";
      session = "";
      startup = "";
      wallpaperChange = "";
    };
    location = {
      analogClockInCalendar = false;
      firstDayOfWeek = -1;
      hideWeatherCityName = false;
      hideWeatherTimezone = false;
      name = "Moncton";
      showCalendarEvents = true;
      showCalendarWeather = true;
      showWeekNumberInCalendar = false;
      use12hourFormat = false;
      useFahrenheit = false;
      weatherEnabled = true;
      weatherShowEffects = true;
    };
    network = {
      bluetoothDetailsViewMode = "grid";
      bluetoothHideUnnamedDevices = false;
      bluetoothRssiPollIntervalMs = 10000;
      bluetoothRssiPollingEnabled = true;
      wifiDetailsViewMode = "grid";
      wifiEnabled = true;
    };
    nightLight = {
      autoSchedule = true;
      dayTemp = "6500";
      enabled = false;
      forced = false;
      manualSunrise = "06:30";
      manualSunset = "18:30";
      nightTemp = "4000";
    };
    notifications = {
      backgroundOpacity = 0.2;
      criticalUrgencyDuration = 15;
      enableBatteryToast = true;
      enableKeyboardLayoutToast = true;
      enableMediaToast = true;
      enabled = true;
      location = "bottom_right";
      lowUrgencyDuration = 3;
      monitors = [

      ];
      normalUrgencyDuration = 8;
      overlayLayer = true;
      respectExpireTimeout = false;
      saveToHistory = {
        critical = true;
        low = true;
        normal = true;
      };
      sounds = {
        criticalSoundFile = "";
        enabled = false;
        excludedApps = "discord,firefox,chrome,chromium,edge";
        lowSoundFile = "";
        normalSoundFile = "";
        separateSounds = false;
        volume = 0.5;
      };
    };
    osd = {
      autoHideMs = 2000;
      backgroundOpacity = 1;
      enabled = true;
      enabledTypes = [
        0
        1
        2
      ];
      location = "right";
      monitors = [

      ];
      overlayLayer = true;
    };
    plugins = {
      autoUpdate = false;
    };
    sessionMenu = {
      countdownDuration = 10000;
      enableCountdown = true;
      largeButtonsLayout = "single-row";
      largeButtonsStyle = true;
      position = "center";
      powerOptions = [
        {
          action = "lock";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
        {
          action = "suspend";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
        {
          action = "hibernate";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
        {
          action = "reboot";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
        {
          action = "logout";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
        {
          action = "shutdown";
          command = "";
          countdownEnabled = true;
          enabled = true;
          keybind = "";
        }
      ];
      showHeader = true;
      showNumberLabels = true;
    };
    settingsVersion = 49;
    systemMonitor = {
      batteryCriticalThreshold = 5;
      batteryWarningThreshold = 20;
      cpuCriticalThreshold = 90;
      cpuPollingInterval = 1000;
      cpuWarningThreshold = 80;
      criticalColor = "";
      diskAvailCriticalThreshold = 10;
      diskAvailWarningThreshold = 20;
      diskCriticalThreshold = 90;
      diskPollingInterval = 30000;
      diskWarningThreshold = 80;
      enableDgpuMonitoring = false;
      externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      gpuCriticalThreshold = 90;
      gpuPollingInterval = 3000;
      gpuWarningThreshold = 80;
      loadAvgPollingInterval = 3000;
      memCriticalThreshold = 90;
      memPollingInterval = 1000;
      memWarningThreshold = 80;
      networkPollingInterval = 1000;
      swapCriticalThreshold = 90;
      swapWarningThreshold = 80;
      tempCriticalThreshold = 90;
      tempWarningThreshold = 80;
      useCustomColors = false;
      warningColor = "";
    };
    templates = {
      activeTemplates = [

      ];
      enableUserTheming = false;
    };
    ui = {
      bluetoothDetailsViewMode = "grid";
      bluetoothHideUnnamedDevices = false;
      boxBorderEnabled = false;
      fontDefault = "MonaspiceNe NFM";
      fontDefaultScale = 1;
      fontFixed = "MonaspiceKr Nerd Font";
      fontFixedScale = 1;
      networkPanelView = "wifi";
      panelBackgroundOpacity = 0.88;
      panelsAttachedToBar = true;
      settingsPanelMode = "attached";
      tooltipsEnabled = true;
      wifiDetailsViewMode = "grid";
    };
    wallpaper = {
      automationEnabled = true;
      directory = "/home/formuna/Data/Wallpapers/Gruvbox";
      enableMultiMonitorDirectories = false;
      enabled = true;
      fillColor = "#000000";
      fillMode = "crop";
      hideWallpaperFilenames = false;
      monitorDirectories = [

      ];
      overviewEnabled = false;
      panelPosition = "follow_bar";
      randomIntervalSec = 300;
      setWallpaperOnAllMonitors = true;
      showHiddenFiles = false;
      solidColor = "#1a1a2e";
      sortOrder = "random";
      transitionDuration = 1500;
      transitionEdgeSmoothness = 0.05;
      transitionType = "random";
      useSolidColor = false;
      useWallhaven = false;
      viewMode = "single";
      wallhavenApiKey = "";
      wallhavenCategories = "111";
      wallhavenOrder = "desc";
      wallhavenPurity = "100";
      wallhavenQuery = "";
      wallhavenRatios = "";
      wallhavenResolutionHeight = "";
      wallhavenResolutionMode = "atleast";
      wallhavenResolutionWidth = "";
      wallhavenSorting = "relevance";
      wallpaperChangeMode = "random";
    };
  };
}
