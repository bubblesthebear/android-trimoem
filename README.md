# android-trimoem
Trim OEM/carrier bloatware

IF ANYONE READS THIS:  I don't know the way any of this github website works

Description:
  Getting a new Android device and going through the system packages in Settings to find what I will never use is tedious.  Automate it.
  Maybe:  If there's a way to apply this thinking as a replacement for Greenify on user phones, that would simpler than teaching them the weird ways Greenify works without root.
  You can use this as a springboard to build a better 'default' experience by optionally adding packages with features or replacing packages with new features otherwise unheard ("I didn't know you could do that with a phone!")


----

Important Notes:
  There can be tiers of trimming, if necessary (though that can get tedious and might result instead in just writing y/n steps for different categories of packages).
  Cannot break any user's functionality.  Do not build the issue where they need or could be aided by a feature they wouldn't know even exists.
  Do not automatically disable features without preferable alternatives unless otherwise reasonable.
  If ANY question of future usability, disable the package instead of uninstalling to allow easy re-enabling.
  Remember that any non-root 'uninstall' of a factory package can be easily reinstalled with all privileges.
  If there is a way to trim factory packages more like trimming Windows Services, that would be instrumental.  Currently unclear what packages have dependencies elsewhere.  Disabling any package has the risk of obscure glitches and avoidance of doubt is the target.



----

Ideas:
  Create 'trim profiles' for devices I currently have access to, then create a script that would trim them automatically if I had factory reset any.  From there, added functions could include automatic install of stock/oem packages that require replacements before uninstall.


----

Notes:

  My original approach was to find bloatware to trim via lists online, but I'm realizing after creating the LG one that I instead should create my own lists as a 'profile' based on real devices I have or can use instead of a giant list to widdle down.  I could instead take something like a Motorola G One and export a profile of all packages currently installed on IT, then reduce from there.  Still very tedious at the start but hopefully less tedious than creating an insane list of every package on every phone from a manufacturer that might be considered bloatware.  Best way to go about it would probably be to create a prototype target using an old Android device, then writing a script that would trim it automatically from factory reset.  That prototype would be a platform thereafter instead of shooting in the dark with information like I am now.
