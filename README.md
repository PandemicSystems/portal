# cimidi-portal
## (https://pandemicsystems.org)
 

<!-- badges: start -->
<!-- badges: end -->

<!--MamalTaxanomydictionary and IUCNRedListHabitatAssociations_Mammals are the lookup tables for the current working set-->

Web portal for coordination and dissemination of research

Public facing website for the Pandemic Systems Group. This site is intended for dissemination of data and research related to funded projects of the Pandemic Systems Group.

This work was supported by the National Science Foundation’s Predictive Intelligence for Pandemic Prevention (PIPP) Phase I grant (#22000158). Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.

Website contact: Éric Marty <emarty@uga.edu>

Website coding: Éric Marty <emarty@uga.edu>, Pavan Bodanki <Pavan.Bodanki@uga.edu>

Contributors: <https://pandemicsystems.org#people>

## Website rendering and hosting

The website is built in R using RMarkdown and some custom css and javascript. 

Each project has its own page on the website which present a summary of results, links to supplemental information, public repositories, preprints, and publications as these become available. 

HTML reports from research projects may be imported from project repositories and rendered here. 
Hosting is on GitHub Pages with a custom domain. Projects involving Shiny or other web applications may be hosted on separate servers and embedded here using iframes.

To render the site locally for preview, clone this repository, open the Rproject in Rstudio, and press the `Build Website` button in the `Build` tab of the `Environment` pane, or run the R command `rmarkdown::render_site()`.

## License

This website and content contained herein are licensed under a 
<a rel="license" href="https://creativecommons.org/licenses/by/4.0/" 
target='_blank'>Creative Commons Attribution 4.0 International License</a>.

<a rel="license" href="https://creativecommons.org/licenses/by/4.0/" target='_blank'>
  <img alt="Creative Commons License" style="border-width:0" 
  src="https://licensebuttons.net/l/by/4.0/80x15.png" /></a>
  
<a href="https://opendefinition.org/" target='_blank'>
  <img src="https://opendefinition.org/assets.okfn.org/images/ok_buttons/oc_80x15_blue.png" alt="This material is Open Content"/></a>
<a href="https://opendefinition.org/" target='_blank'>
  <img src="https://opendefinition.org/assets.okfn.org/images/ok_buttons/od_80x15_blue.png" alt="This material is Open Data"/></a>
  
Privacy policy: <https://eits.uga.edu/access_and_security/infosec/pols_regs/policies/privacy/>
