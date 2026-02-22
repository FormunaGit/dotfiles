{ inputs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = false;
    discord = {
      equicord.enable = true; # Enable Equicord
      vencord.enable = false;
    };
    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      plugins = {
        #amITyping.enable = true;
        alwaysExpandProfiles.enable = true;
        betterCommands.enable = true;
        betterSettings.enable = true;
        callTimer.enable = true;
        crashHandler.enable = true;
        decor.enable = true;
        discordDevBanner.enable = true;
        equicordToolbox.enable = true;
        exportMessages.enable = true;
        expressionCloner.enable = true;
        fakeNitro.enable = true;
        friendCloud.enable = true;
        friendsSince.enable = true;
        gifCollections.enable = true;
        gifPaste.enable = true;
        globalBadges.enable = true;
        guildPickerDumper.enable = true;
        homeTyping.enable = true;
        iconViewer.enable = true;
        iLoveSpam.enable = true;
        memberCount.enable = true;
        messageLinkEmbeds.enable = true;
        messageLoggerEnhanced.enable = true;
        moreCommands.enable = true;
        newPluginsManager.enable = true;
        noF1.enable = true;
        noModalAnimation.enable = true;
        noMosaic.enable = true;
        noOnboardingDelay.enable = true;
        noTypingAnimation.enable = true;
        pauseInvitesForever.enable = true;
        permissionsViewer.enable = true;
        petpet.enable = true;
        pictureInPicture.enable = true;
        previewMessage.enable = true;
        questify.enable = true;
        quickMention.enable = true;
        reactErrorDecoder.enable = true;
        readAllNotificationsButton.enable = true;
        relationshipNotifier.enable = true;
        remixRevived.enable = true;
        sendTimestamps.enable = true;
        serverInfo.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        showMeYourName.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        viewRaw.enable = true;
        voiceChatUtilities.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        whoReacted.enable = true;
        quoter.enable = true;

        betterQuickReact = {
          enable = true;
          rows = 4.0;
          columns = 6.0;
        };

        betterSessions = {
          enable = true;
          backgroundCheck = true;
        };

        experiments = {
          enable = true;
          toolbarDevMenu = true;
        };

        favoriteGifSearch = {
          enable = true;
          searchOption = "url";
        };
      };
    };
  };
}
