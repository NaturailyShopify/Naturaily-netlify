---
title: How to Maintain Performance with Big Datasets Using Highcharts.js and Vue
description: >-
  Highcharts is a powerful tool that allows you to plot massive series of data
  in a dynamic manner. 
slug: big-datasets-highcharts-vue
layout: post
date: '2019-11-04 10:56:21 +0200'
category: JavaScript development
authors:
  avatar: /assets/images/andrzej_profile.png
  label: Andrzej Gatkowski
  value: author-29
image: /assets/images/wrocloverb_highlights.jpeg
text-preview: >-
  Sometimes you just need to show big datasets in your project. However, the
  library that you’ve used so far, as soon as you start to add data, becomes
  clunky and slow. You start to optimize your code, make cuts, or
  simplifications in datasets… but it doesn't need to be this way! In this
  article, I’m going to show you that it does not have to be that way.
tags:
  - JavaScript
  - Vue
  - Highcharts.js
---
**Sometimes you just need to show big datasets in your project. However, the library that you’ve used so far, as soon as you start to add data, becomes clunky and slow. You start to optimize your code, make cuts, or simplifications in datasets… but it doesn't need to be this way! In this article I’m going to show you that it does not have to be that way.**

Used by “[80% of the largest companies in the world](https://www.highcharts.com/blog/products/highcharts/){:rel="nofollow"}{:target="_blank"}”, Highcharts is a powerful tool that allows you to plot massive series of data in a dynamic manner. As it’s free for non-commercial use, you can easily check for yourself if it’s going to suit your tastes. This project will also use highcharts-vue, which is a wrapper for Highcharts.

### Installation:

The tools that we are going to need for the job are:

* Highcharts
* Highcharts vue
* Axios

You can easily install them all at once using npm command:

npm i highcharts highcharts-vue axios -S



Now that we have all the pieces, lets add them in the main.js file:
```javascript
import Highcharts from "highcharts";
import HighchartsVue from "highcharts-vue";
import boost from "highcharts/modules/boost";
 
Vue.use(HighchartsVue);
boost(Highcharts);
```
