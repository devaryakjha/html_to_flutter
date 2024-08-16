import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_to_flutter_kit/html_to_flutter_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Html(
        config: HtmlConfig(
          onTap: (url, [attributes, element]) {
            log('Tapped on $url');
            log('Attributes: $attributes');
            log('Element: $element');
          },
          extensions: [
            const TableExtension(),
          ],
        ),
        renderMode: RenderMode.list,
        data:
            """\n<p><strong>1. How is dividend income received from my equity shares and mutual funds taxed?</strong></p>\n<p>Any dividends you receive from your stock investments and mutual funds are taxable at slab rates and are reported under the head ‘income from other sources’.</p>\n<p>If your dividend income exceeds ₹5,000, the entity paying you is required to deduct a 10% TDS.</p>\n<p>For example, if you receive ₹10,000 as dividends from Company A, they’ll deduct 10% TDS, and you’ll receive ₹9,000. You must report this dividend income as ‘income from other sources’ when filing your ITR.</p>\n<p>Say, if you also have a salary income of ₹22 lakh, which places you in the highest tax slab of 30%, the ₹10,000 dividend will be added to your total income. Accordingly, your tax liability will be calculated on ₹22,10,000.</p>\n<p>However, you will be able to claim the ₹1,000 TDS as tax credits while filing your ITR.</p>\n<p><strong>2. The company that I invested in 2015 has given me bonus shares in the ratio of 2:1 in April 2023. In 2015, I bought 100 shares at cost of ₹50 per share. In 2023, it became 300 shares after the bonus issue. I sold 150 shares in February 2024 for ₹100. How am I taxed now?</strong></p>\n<p>Bonus shares are new shares issued to existing shareholders without any additional expense.</p>\n<p>When such shares are issued, there will be two transactions:</p>\n<p><strong>When you receive the bonus shares:</strong> The cost price is considered to be zero, and hence, you are not liable to pay any taxes on them as there are no capital gains.</p>\n<p><strong>When the shares are sold:</strong> Capital gains tax is levied on the sale of shares on a FIFO (First in first out) basis. The bonus shares’ purchase cost is considered zero, and the date of purchase will be taken as the date on which the bonus shares were issued.</p>\n<p>For your case, 200 shares were issued as a bonus, and the total number of shares held after the bonus will be 300. Now, as per the FIFO method, when 150 shares are sold, the original 100 shares will be sold first, followed by the remaining 50 bonus shares.</p>\n<p>The capital gains will be calculated as follows:</p>\n<p><!-- notionvc: c1df31c2-233e-44e6-bd12-9bec5a6434f3 --></p>\n<p><!-- notionvc: 330776bc-17b7-4718-ad29-33b05b8a3dfb --></p>\n\n\n\n<figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-6 is-layout-flex wp-block-gallery-is-layout-flex\"></figure>\n\n\n\n<figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-7 is-layout-flex wp-block-gallery-is-layout-flex\">\n<figure class=\"wp-block-image size-large\"><a href=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658.png\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"552\" data-id=\"384295\" src=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-1024x552.png\" alt=\"\" class=\"wp-image-384295\" srcset=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-1024x552.png 1024w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-300x162.png 300w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-768x414.png 768w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-1536x828.png 1536w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-1410125658-2048x1104.png 2048w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" /></a></figure>\n</figure>\n\n\n\n<p>As the holding period here is more than 12 months, gains will be long-term and taxed at 10%.</p>\n\n\n\n<p></p>\n\n\n\n<figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-8 is-layout-flex wp-block-gallery-is-layout-flex\">\n<figure class=\"wp-block-image size-large\"><a href=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903.png\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"513\" data-id=\"384297\" src=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-1024x513.png\" alt=\"\" class=\"wp-image-384297\" srcset=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-1024x513.png 1024w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-300x150.png 300w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-768x385.png 768w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-1536x770.png 1536w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323903-2048x1026.png 2048w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" /></a></figure>\n</figure>\n\n\n\n<p>As the holding period is less than 12 months, gains will be short-term and taxed at 15%.</p>\n\n\n\n<p></p>\n\n\n\n<p><strong>3. I invested in a small-cap company called X in 2017 &#8211; 100 shares at ₹50. The company took corporate action to split the shares in a ratio of 5:1 in 2022. That means, for every one share I bought, I now have 5 shares &#8211; 500 shares. I am planning to sell half of my holdings now at ₹40 per share. What is the cost of acquisition? What will be my capital gains tax liability?</strong></p>\n\n\n\n<p>Whenever a stock split happens, the price per share is adjusted based on the split ratio. So, to calculate the tax liability, we’ll first have to determine the share price.</p>\n\n\n\n<figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-9 is-layout-flex wp-block-gallery-is-layout-flex\">\n<figure class=\"wp-block-image size-large\"><a href=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1.png\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"370\" data-id=\"384306\" src=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-1024x370.png\" alt=\"\" class=\"wp-image-384306\" srcset=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-1024x370.png 1024w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-300x108.png 300w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-768x278.png 768w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-1536x555.png 1536w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323904-1-2048x740.png 2048w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" /></a></figure>\n</figure>\n\n\n\n<p></p>\n\n\n\n<p>Now, the date of purchase for the split stocks is considered the same as the original stocks. Hence, your holding period does not change. If you decide to sell off half the holdings, which is 250 shares, the capital gains will be calculated as follows;</p>\n\n\n\n<figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-10 is-layout-flex wp-block-gallery-is-layout-flex\">\n<figure class=\"wp-block-image size-large\"><a href=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905.png\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"551\" data-id=\"384298\" src=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-1024x551.png\" alt=\"\" class=\"wp-image-384298\" srcset=\"https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-1024x551.png 1024w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-300x161.png 300w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-768x413.png 768w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-1536x827.png 1536w, https://zerodha.com/z-connect/wp-content/uploads/2024/07/Frame-2087323905-2048x1102.png 2048w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" /></a></figure>\n</figure>\n\n\n\n<p></p>\n\n\n\n<p><strong>4. I invested in a company, ABC, in March 2024, purchasing 100 shares. The company announced a buyback offer in December 2024, and I surrendered half of my holdings in this buyback. I made profits to the extent of Rs 50 per share. Are my gains taxable?</strong></p>\n\n\n\n<p>The profits that you make by participating in a buyback are exempted from taxes u/s 10(34A) of Income Tax. Hence, these gains are entirely tax-free, and you can report them under Schedule EI (Exempt Income) when filing your ITR.</p>\n\n\n\n<p></p>\n\n\n\n<p><strong>5. My shares in company XYZ have been merged with a parent company. I sold all the merged shares in FY 23-24. How will it be taxed?</strong></p>\n\n\n\n<p>Capital gains on the sale of such shares are calculated on the basis of the holding period and the date of acquisition of shares. When you receive shares in the new company as part of a merger, both the holding period and cost of purchase are considered from the original shares of the amalgamated company. So, in your case, the capital gains will be simply the difference between your total buy price (when you bought shares of company XYZ) and total sell price. If the shares of XYZ were taken before 12 months, gains will be long-term and taxed at 10%. If the holding period is less than a year, gains will be short-term and taxed at 15%.</p>\n\n\n\n<p></p>\n\n\n\n<p><em>The above questions are answered by Surbhi Pal from Quicko. This is for informational purposes only. Consult your tax expert for individualized advice.</em></p>\n""",
      ),
    );
  }
}
