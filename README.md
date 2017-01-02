# ORT - A book group website 

Version 1.0

Author: Scott Wilson
<http://www.thatsoftwareguy.com>

## Overview
For many years, I have been building a static website by hand for my book group.  The <a href="https://affiliate-program.amazon.com/home">Amazon Affiliate program</a> allows you to easily build the HTML that produces the link and provides the image of the book.  However, this technique was <a href="#history">not without problems</a>.  Finally, in late 2016, I discovered that link rot had affected some of the links created a few years ago (they no longer worked due to changes by Amazon), so I realized I had to take a different approach. 

I knew the best solution would be to use an API to generate the links under the control of a static site generator, but I wasn't aware of any SDK toolsets that facilitated the use of the <a href="http://docs.aws.amazon.com/AWSECommerceService/latest/DG/ProgrammingGuide.html">Product Advertising API</a>.  Since I had very carefully <i>not searched</i> for any such utilities, this lack of awareness was mostly cluelessness on my part. :(

I initially wanted to use <a href="https://gohugo.io/">Hugo</a>, but I stumbled upon a gem that took care of the Amazon Affiliate lookups, so I realized that Ruby was the way to go.

<ul>
<li><a href="http://jekyllrb.com/">Jekyll</a> - A static site generator</li>
<li><a href="https://github.com/JuanjoSalvador/hyde">Hyde</a> - A fork of the Hyde template which is compatible with Jekyll 3.x</li>
<li><a href="https://github.com/tokzk/jekyll-amazon">jekyll-amazon</a> - A gem that converts Jekyll tags into Amazon affiliate links with associated images and data. </li>
</ul>

## Usage

Once you have this toolset installed and working, it's just a matter of building pages in Markdown or HTML that contain links to your selections, i.e. 

<pre>
{&#37; amazon &lt;ASIN&gt; detail &#37;}
</pre>

Pages with layout set to `page` will appear in the navbar.  I limited the number of pages shown in the navbar to make the site easier to use on mobile, but you can change this by updating `_includes/sidebar.html` and setting `MAX_NAV_PAGES` to some large value.

To build the site during development, use the command 

`$ jekyll build`

which will put the output in _site. 

To build for production, use the command 

`$ jekyll build --config=_config_prod.yml`

which will build the output in the directory specified in the `destination` variable in `_config_prod.yml`.

## Author

**Scott Wilson**
- <https://github.com/scottcwilson>
- <https://twitter.com/thatsoftwareguy>


## License

Open sourced under the [MIT license](LICENSE.md).

## History
Here's the Amazon Affiliate link for <i>The Ruby Programming Language</i>, produced by the Amazon Affiliate product search tool in January 2017.   

<pre>
&lt;a target="_blank"  href="https://www.amazon.com/gp/product/0596516177/ref=as_li_tl?ie=UTF8&amp;camp=1789&amp;creative=9325&amp;creativeASIN=0596516177&amp;linkCode=as2&amp;tag=thatsoftwareg-20&amp;linkId=7dd3b7d895b70055f8c1aa8213403a63"&gt;&lt;img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&amp;MarketPlace=US&amp;ASIN=0596516177&amp;ServiceVersion=20070822&amp;ID=AsinImage&amp;WS=1&amp;Format=_SL250_&amp;tag=thatsoftwareg-20" &gt;&lt;/a&gt;&lt;img src="//ir-na.amazon-adsystem.com/e/ir?t=thatsoftwareg-20&amp;l=am2&amp;o=1&amp;a=0596516177" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /&gt;
</pre>

There are several reasons why this is not valid XHTML: 

* The `&#38;` character should be coded as `&#38;amp;`
* There is no `alt` tag for the image
* The first `img` tag is not closed

But there's a bigger danger: the path for the image used in this link is subject to change by Amazon.  Here's an Affiliate link from 2013 that worked for several years, but then just stopped working.  (The issues noted above have been fixed in this code block.)

<pre>
&lt;a href="http://www.amazon.com/gp/product/B0052HKL4G/ref=as_li_tf_il?ie=UTF8&amp;tag=thatsoftwareg-20&amp;linkCode=as2&amp;camp=1789&amp;creative=9325&amp;creativeASIN=B0052HKL4G"&gt;&lt;img border="0" src="http://ws.assoc-amazon.com/widgets/q?_encoding=UTF8&amp;Format=_SL160_&amp;ASIN=B0052HKL4G&amp;MarketPlace=US&amp;ID=AsinImage&amp;WS=1&amp;tag=thatsoftwareg-20&amp;ServiceVersion=20070822" alt="" /&gt;&lt;/a&gt;&lt;img src="http://www.assoc-amazon.com/e/ir?t=thatsoftwareg-20&amp;l=as2&amp;o=1&amp;a=B0052HKL4G" width="1" height="1" border="0" style="border:none !important; margin:0px !important;" alt="Nemesis" /&gt;
</pre>

API-generated links will get the most current image paths from Amazon, and are thus safer.
