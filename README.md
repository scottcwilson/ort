# ORT - A book group website 

Version 1.0

Author: Scott Wilson
<http://www.thatsoftwareguy.com>

## Overview
For many years, I have been building a static website by hand for my book group.  The <a href="https://affiliate-program.amazon.com/home">Amazon Affiliate program</a> allows you to easily build the HTML that produces the link and provides the image of the book.  However, this technique was <a href="#history">not without problems</a>.  Finally, in late 2016, I discovered that link rot had affected some of the links created a few years ago (they no longer worked due to changes by Amazon), so I realized I had to take a different approach. 

I knew the best solution would be to use an API to generate the links under the control of a static site generator, but I wasn't aware of any SDK toolsets that facilitated the use of the <a href="http://docs.aws.amazon.com/AWSECommerceService/latest/DG/ProgrammingGuide.html">Product Advertising API</a>.  Since I had very carefully <i>not searched</i> for any such utilities, this lack of awareness was mostly cluelessness on my part. :(

I initially wanted to use <a href="https://gohugo.io/">Hugo</a>, but I stumbled upon a gem that took care of the Amazon Affiliate lookups, so I realized that Ruby was the way to go.  So here are the tools I chose: 

<ul>
<li><a href="http://jekyllrb.com/">Jekyll</a> - A static site generator</li>
<li><a href="https://github.com/JuanjoSalvador/hyde">Hyde</a> - A fork of the Hyde template which is compatible with Jekyll 3.x</li>
<li><a href="https://github.com/tokzk/jekyll-amazon">jekyll-amazon</a> - A gem that converts Jekyll tags into Amazon affiliate links with associated images and data. </li>
</ul>

## Usage

Your first step is to get an [Amazon Affiliates account](https://affiliate-program.amazon.com/).  Once you have done this, you will need to create an AWS Account associated with your affiliates account to use the Product Advertising API.
The steps for this are shown [in the documentation](http://docs.aws.amazon.com/AWSECommerceService/latest/DG/CHAP_GettingStarted.html). 

Next, install Jekyll and find a template you like.  I used Hyde because it had sidebar navigation, which is useful if you have a lot of content pages, but there are many choices.  Try setting up some pages and adding some content to get a feel for using Jekyll.

Then do a `gem install jekyll-amazon` to get the Jekyll tag generator.
See the documentation on that gem for the environment variables you need 
to set in order to use the API. 

Once you have the tools installed and working, it's just a matter of building pages in Markdown or HTML that contain links to your selections, i.e. 

<pre>
{&#37; amazon &lt;ASIN&gt; detail &#37;}
</pre>

(Note that I used the tag `short_detail` because I wanted less information, with a different layout.)

Pages with layout set to `page` will appear in the navbar.  I limited the number of pages shown in the navbar to make the site easier to use on mobile, but you can change this by updating `_includes/sidebar.html` and setting `MAX_NAV_PAGES` to some large value.

To build the site during development, use the command 

`$ jekyll build`

which will put the output in the `_site` directory. 

To build for production, use the command 

`$ jekyll build --config=_config_prod.yml`

which will build the output in the directory specified in the `destination` variable in `_config_prod.yml`.

The build also produces a `sitemap.xml` file, which may be used with Google 
Webmaster tools. 

## Author

**Scott Wilson**
- <https://github.com/scottcwilson>
- <https://twitter.com/thatsoftwareguy>


## License

Open sourced under the [MIT license](LICENSE.md).

<div id="history"></div>

## History
Here's the Amazon Affiliate link for <i>The Ruby Programming Language</i>, produced by the Amazon Affiliate product search tool in January 2017.   

```
<a target="_blank"  href="https://www.amazon.com/gp/product/0596516177/ref=
as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0596516177
&linkCode=as2&tag=thatsoftwareg-20&
linkId=7dd3b7d895b70055f8c1aa8213403a63">
<img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8
&MarketPlace=US&ASIN=0596516177&ServiceVersion=20070822
&ID=AsinImage&WS=1&Format=_SL250_&tag=thatsoftwareg-20" ></a>
<img src="//ir-na.amazon-adsystem.com/e/ir?t=thatsoftwareg-20&l=am2
&o=1&a=0596516177" width="1" height="1" border="0" alt=""
style="border:none !important; margin:0px !important;" />
```

There are several reasons why this is not valid XHTML: 

* The `&` character should be coded as `&amp;`
* There is no `alt` tag for the image
* The first `img` tag is not closed

But there's a bigger danger: the path for the image used in this link is subject to change by Amazon.  Here's an Affiliate link from 2013 that worked for several years, but then just stopped working.  (The issues noted above have been fixed in this code block.)

```
<a href="http://www.amazon.com/gp/product/B0052HKL4G/ref=as_li_tf_il?ie=UTF8
&amp;tag=thatsoftwareg-20&amp;linkCode=as2&amp;camp=1789&amp;creative=9325
&amp;creativeASIN=B0052HKL4G">
<img border="0" src="http://ws.assoc-amazon.com/widgets/q?_encoding=UTF8
&amp;Format=_SL160_&amp;ASIN=B0052HKL4G&amp;MarketPlace=US&amp;ID=AsinImage
&amp;WS=1&amp;tag=thatsoftwareg-20&amp;ServiceVersion=20070822" alt="" /></a>
<img src="http://www.assoc-amazon.com/e/ir?t=thatsoftwareg-20&amp;l=as2
&amp;o=1&amp;a=B0052HKL4G" width="1" height="1" border="0" style="border:none 
!important; margin:0px !important;" alt="Nemesis" />
```

API-generated links will get the most current image paths from Amazon, and are thus safer.
