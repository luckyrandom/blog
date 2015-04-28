---
title: R library search path
author: Chenliang Xu
date: 2014-07-22 17:00
template: post.html
---

When 'library()' or 'require()' is called, R load packages from
library search paths, which consists of three different directory,

* '.Library' is a character string giving the location of the defualt
  library, with default value `$R_HOME/library`
* '.Library.site' is a character string vector giving the location of
  the site libraries, with defualt value `$R_HOME/site-library`
* User library paths. There is no variable corresponding to it, but it
  can be get and set with function '.libPaths()'



R startup with the following steps,

* Set environment variables unless '--no-environ was given on the command line
 * Load site environment variables from `$R_ENVIRON` or `$R_HOME/etc/Renviron.site`
 * Load user environment variables from `.Renviron` in the current or home directory 
* Load startup profile files, containing R code. Only the 'base'
  package is loaded, when the profiles are loaded.
 * Load site profile file from `$R_PROFILE` OR `$R_HOME/etc/Rprofile.site`
 * Load user profile `.Rprofile` from the current or home directory
* Load `.RData` unless '--no-restore' or similar arguments was given on the command line
* Call function '.First()' if it exists. It can be defined in profile files or loaded from `.RData`.
* Call function '.First.sys()' provided by 'base' package, which load
  all the packages specified by 'options("defaultPackages")'.

# Reference

* [help(".libPaths")](http://stat.ethz.ch/R-manual/R-patched/library/base/html/.libPaths.html)
