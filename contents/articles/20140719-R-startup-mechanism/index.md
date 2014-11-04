---
title: R startup mechanism
author: Chenliang Xu
date: 2014-07-19 12:30
template: articles.html
---

R startup with the following steps,

* Set environment variables unless '--no-environ was given on the command line
 * Load site environment variables from "$R\_HOME/etc/Renviron"
 * Load site environment variables from "$R\_ENVIRON" or "$R\_HOME/etc/Renviron.site"
 * Load user environment variables from ".Renviron" in the current or home directory 
* Load startup profile files, containing R code. Only the 'base'
  package is loaded, when the profiles are loaded.
 * Load site profile file from "$R\_PROFILE" OR "$R\_HOME/etc/Rprofile.site"
 * Load user profile ".Rprofile" from the current or home directory
* Load ".RData" unless '--no-restore' or similar arguments was given on the command line
* Call function '.First()' if it exists. It can be defined in profile files or loaded from ".RData".
* Call function '.First.sys()' provided by 'base' package, which load
  all the packages specified by 'options("defaultPackages")'.

# Reference

* [help("Startup")](http://stat.ethz.ch/R-manual/R-patched/library/base/html/Startup.html)
