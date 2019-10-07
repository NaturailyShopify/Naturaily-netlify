---
title: RubyC 2019 Highlights
description: >-
  As soon as we knew the date of the RubyC, we immediately booked seats on the
  plane from Wroclaw to Kiev. We had to be there, Naturaily.
slug: rubyc-2019-highlights
layout: post
date: '2019-10-07 08:55:38 +0200'
category: Events
author: Beata Twardowska
authors: Beata Twardowska
avatar: /assets/images/beata.jpg
image: /assets/images/rubyc-2019-highlights.jpg
text-preview: >-
  RubyC is a European conference devoted to Ruby, Rails and other related
  technologies. Hundreds of Ruby enthusiasts and developers gather to exchange
  knowledge, discuss the latest news and learn from each other. As soon as we
  knew the date of the conference, we immediately booked seats on the plane from
  Wroclaw to Kiev. We had to be there, Naturaily.
tags:
  - RubyC
  - Ruby
  - Rails
  - Ruby on Rails Development
---
**RubyC is a European conference devoted to Ruby, Rails and other related technologies. Hundreds of Ruby enthusiasts and developers gather to exchange knowledge, discuss the latest news and learn from each other. As soon as we knew the date of the conference, we immediately booked seats on the plane from Wroclaw to Kiev. We had to be there, Naturaily.**

Conference details:

* date: 14-15 September
* place: Kiev
* venue: Premier Hotel RUS

Our representatives: **Dominik** & **Stefan**

![Ruby on rails developers at the RubyC conference](/assets/images/rubyc_1.png)

## What impression did the conference make on them? Here's what they told us on their return.

First of all, they highly rated the substantive level of the conference and the atmosphere of the entire event. Kudos to all the organizers! Most of the speeches were very valuable. Below, you will find the summary of those that Stefan and Dominik found the most memorable.

\###Dominik's review

The most interesting and valuable presentation was the one given by **Ivan Shamotov,** entitled: "It's all about money, money, money".

> Ivan is a Ruby developer since 1.8.6 and a Rails developer since Rails and Merbe merged. A huge part of his career has been connected with billing domains and how he is fully dedicated to the Ruby community at Saint Petersburg. - [source](https://rubyc.eu/#speakers){:rel="nofollow"}{:target="_blank"}

If you are a Ruby Developer, there is a high probability that one of your recruitment tasks was to write a Fibonacci sequence using recurrency. The speaker of the presentation told us what other things we can thank Fibonacci for, gave a brief explanation about the Double Entry Accounting System and shared a few general rules on how to deal with money during a project.

Here they are:

* Never use **floats** to make money calculations. If you don't know why, [this page](https://0.30000000000000004.com/){:rel="nofollow"}{:target="_blank"} may be a hint. 
* Use **a decimal with a correct scale** and precision in the database. You may think that an integer in the best way to go, but it won't work with cryptocurrencies, where the fraction is constantly changing. 
* Sometimes you want to round up, and sometimes you want to round down - **use rounding wisely**. Also, remember to take care of fees that you have to pay to e.g., a payment gateway. You can't round them down, obviously, but if you pay fees monthly, you may want to calculate and store each fee with the biggest precision you can get and then round the sum of it - this way, the eventual amount will be smaller.
* Make sure your sheet is balanced in your double-entry bookkeeping system. 
  Assets = Liabilities + Equity

Sounds interesting? You can watch the whole presentation here:

{% youtube v=x4nMt0MfBGk %}

The second presentation I find worth mentioning is the one given by **Yevhen Kuzminov**, entitled: "A year with Hanami in production: the Good, the Bad and some Recipes".

> Yevhen is a Ruby team leader in MobiDev. He’s gone all the way from PHP "one-pager" development to the full-stack, in addition to building Ruby and Blockchain teams from scratch. Author of the "Ruby Web Dev: The Other Way" and the "Hanami Cookbook". - [source](https://rubyc.eu/#speakers){:rel="nofollow"}{:target="_blank"}

