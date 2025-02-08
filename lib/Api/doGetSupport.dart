import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Classes/MyException.dart';
import '../Common/CommonText.dart';
import '../Models/LoginUser.dart';
import '../Models/Response.dart';
import '../Models/SupportData.dart';

class DoGetSupport
{
  Future<List<SupportData>> call() async
  {
    return [
      SupportData(name: "About Us", action: "about", title: "About Us", content: about),
      SupportData(name: "Privacy Policy", action: "privacy", title: "Privacy Policy", content: privacy),
      SupportData(name: "Help", action: "help", title: "Help", content: help),
      SupportData(name: "Disclaimer", action: "disclaimer", title: "Disclaimer", content: disclaimer)
    ];
  }

  String disclaimer = '''
  (the "App") is provided "as is" and "as available" without any warranties of any kind, either express or implied.  [Your Company/Name] (the "Provider") does not warrant that the App/Website will be uninterrupted, secure, or error-free, or that any defects will be corrected.

USE OF APP

Your use of the App/Website is at your sole risk. The Provider shall not be liable for any direct, indirect, incidental, consequential, or special damages arising out of or in connection with your use of the App/Website, even if the Provider has been advised of the possibility of such damages.
    ''';

  String help = '''
  helppppp
    ''';

  String about = '''
  <h2 class="ui-e--highlighted-text">
        <span class="ui-e-headline-text elementor-repeater-item-b572f57">As a wholly owned subsidiary of PROVEN Group Limited, the Company is built on a strong capital base and track record of success.</span>        </h2>
  <div><p><span style="font-weight: 400;">PROVEN Wealth Limited (PWL) is one of the Caribbean’s premier wealth management companies, managing billions of dollars of assets on behalf of our institutional and individual clients. As a wholly- owned subsidiary of the PROVEN Group Limited (PROVEN/PGL), the company is built on a strong capital base and track record of success.</span></p><p><span style="font-weight: 400;">Our expertise covers a range of areas, including wealth management, financial planning, and investment banking. All our advice is carefully curated to ensure it is adapted to individual requirements, and we pride ourselves on providing a truly bespoke experience.</span></p><p><span style="font-weight: 400;">Our focus is to protect, accumulate and manage the wealth of our valued clients through an intimate portfolio management strategy and to provide an investment portfolio of local, regional &amp; international securities that fits the specific financial goals of our clients.</span></p></div>
  ''';

  String privacy = '''<div>
                    
<h2 class="wp-block-heading">PROVEN Wealth Limited (“PWL”) has created this privacy policy to demonstrate our firm commitment to the privacy of personal information provided by clients who utilise our products and services. We hold the privacy of our clients’ personal information in the highest regard.</h2>



<p>We recognize the importance of protecting your privacy and our policy is designed to assist you in understanding how we collect, use and safeguard the information you provide to us and to assist you in making informed decisions when using our website, mobile applications and other electronic services that aggregately support our offerings. This policy will be continuously assessed against new technologies, international best practices, general data protection and privacy regulations as well as our evolving clients’ needs.</p>



<p><strong>What Information Do We Collect?</strong></p>



<p>When you access our products and services you may provide us with two types of information: personal information you knowingly choose to disclose that is collected on an individual basis and website use information collected on an aggregate basis as you browse our website or use our mobile applications.</p>



<p><strong>1. Personal Information you Choose to Provide</strong></p>



<p><strong>Registration and/or Account Opening Information</strong></p>



<p>When you register or apply for any of our products or services you will be required to provide us with information about yourself.If you choose to access any of our products and services, you may need to give personal information such as, but not limited to: name; marital status; occupation and income details; mailing address; e-mail address; business, home and mobile phone numbers.</p>



<p><strong>Email Information</strong></p>



<p>If you choose to correspond with us through email, we may retain the contents of your email messages together with your email address and our responses. We provide the same protections for these electronic communications that we employ in the maintenance of information received by mail and telephone.</p>



<p><strong>How do we use the information that you provide us?</strong></p>



<p>Generally, we use personal information for the purposes of administering our business activities, providing the products and services you requested, processing your payment, monitoring the use of our services, aiding our marketing and promotional efforts, improving our content and service offerings, customizing our website’s content, layout and services as well as other lawful purposes. These uses assist to improve our products and services and better tailor them to meet our clients’ needs.Furthermore, such information may be shared with others on an aggregate basis. Personally identifiable information or business information will not be shared with parties except as required by law.</p>



<p>Occasionally, we may also use the information we collect to notify you about important changes to our website, mobile applications, new services, and special offers we think you will find valuable. You may notify us at any time if you do not wish to receive these offers by emailing us at info@provewealth.com or by selecting the unsubscribe links, where applicable.</p>



<p><strong>2. Website Use Information</strong></p>



<p>Similar to other websites, our website utilizes a standard technology called “cookies” (see explanation below) and web server log files to collect information about how our website is used. Information gathered through cookies and Web server logs may include the date and time of visits, the pages viewed, time spent on our website, and the websites visited immediately before and immediately after your visit to our website.</p>



<p><strong>What are Cookies?</strong></p>



<p>A cookie is a very small text document, which often includes an anonymous unique identifier. When you visit a website, that website’s computer asks your computer for permission to store this file in a part of your hard drive specifically designated for cookies. Each Web site can send its own cookie to your browser if your browser’s preferences allow it, but (to protect your privacy) your browser only permits a website to access the cookies it has already sent to you, not the cookies sent to you by other websites. Browsers are usually set to accept cookies. However, if you would prefer not to receive cookies, you may alter the configuration of your browser to refuse cookies. If you choose to have your browser refuse cookies, it is possible that some areas of our website will not function as effectively when viewed by the users. A cookie cannot retrieve any other data from your hard drive or pass on computer viruses.</p>



<p><strong>How do we use information we collect from Cookies?</strong></p>



<p>As you visit and browse our website, cookies are used to differentiate you from other users. In some cases, we also use cookies to prevent you from having to log in more than is necessary for security reasons. Cookies, in conjunction with our Web server’s log files, allow us to calculate the aggregate number of people visiting our website and which pages of our website are most frequently visited. This helps us gather feedback to constantly improve our website and better serve our clients. Cookies do not allow us to gather any personal information about you and we do not intentionally store any personal information that your browser provided to us via cookies.</p>



<p><strong>IP Addresses</strong></p>



<p>IP addresses are used by your computer every time you are connected to the Internet. Your IP address is a number that is used by computers on the network to identify your computer. IP addresses are automatically collected by our web server as part of demographic and profile data known as traffic data so that more relevant information can be shared with you.</p>



<p><strong>Sharing and Selling Information</strong></p>



<p>We do not share, sell, lend or lease any of the information that uniquely identify a subscriber (such as email addresses or personal details) with anyone except to the extent that is necessary to process transactions, provide services that you have requested or as is required by law.</p>



<p>If third party companies are contracted to perform services for us on our behalf, then the contractual arrangement will require such companies to keep the information we provide confidential and to only use such information to the extent of the authorisation we provide.</p>



<p><strong>How can you access and Correct your Personal Information?</strong></p>



<p>You may request access to all your personally identifiable information that we collect online or otherwise and maintain in our database by emailing us at info@provenwealth.com or by calling us at 1-876-908-3800.</p>



<p><strong>Location of your Client Record</strong></p>



<p>Your client record, whether electronic or paper, is kept at the offices of PWL. Paper records forming part of your client record may also be kept in offsite storage. In accordance with our disaster recovery policies, your client record may be transferred to other locations overseas.</p>



<p><strong>What about Legally Compelled Disclosure of Information?</strong></p>



<p>We may disclose information when legally compelled to do so, in other words, when we, in good faith, believe that the law requires it or for the protection of our legal rights. We may also disclose account information when we have reason to believe that disclosing this information is necessary to identify, contact or bring legal action against someone who may be violating PWL’s Terms and Conditions or to protect the safety of our users and the general public.</p>



<p><strong>What about other websites linked to our website?</strong></p>



<p>We are not responsible for the practices employed by websites linked to or from our website or the information or content contained therein. Often links to other websites are provided solely as pointers to information on topics that may be useful to the users of our website.</p>



<p>Please remember that when you use a link to go from our website to another, our Privacy Policy is no longer applicable. Your browsing and interaction on any other website, including websites which have a link on our website, is subject to that website’s own rules and policies. It is highly recommended that you read the rules and policies governing those websites before utilising same.</p>



<p><strong>Your Consent</strong></p>



<p>By using our website and other electronic services you consent to our collection and use of your personal information as described in this Privacy Policy. We reserve the right to amend this policy at any time with or without notice.</p>



<p><strong>Our Commitment to Data Security</strong></p>



<p>Please note that your information will be on our secure servers using the most up to date global data compliance policies and technology. To prevent unauthorized access, maintain data accuracy and ensure the correct use of information, we have put in place appropriate physical, electronic, and managerial procedures to safeguard and secure the information we collect online.</p>



<p><strong>Limits on time that Personal Information is kept</strong></p>



<p>PWL will hold your personal information as long as it is necessary or as required by law. If or when PWL destroys the information, PWL will use safeguards to prevent unauthorized parties from gaining access to the information during such process.</p>



<p><strong>Choice/Opt-In/Opt-Out</strong></p>



<p>Our website, mobile applications, trading platforms and other electronic offerings allow clients to voluntarily subscribe, unsubscribe or cease to utilize the services. Consequently, future access to that service is conditional on the action taken.Surveys</p>



<p>From time-to-time our website requests information from users via surveys. Participation in these surveys is completely voluntary and the user therefore has a choice whether or not to disclose this information. Information requested may include contact (such as name) and demographic details (such as Country of Residency). Survey information will be used for the purposes of monitoring or improving the use of and to measure your satisfaction with our products, services and corporate citizenship initiatives.</p>



<p><strong>Acquisition or Changes in Ownership</strong></p>



<p>In the event that the website (or a substantial portion of its assets) is acquired, your information may be deemed a part of those assets and may be transferred to the acquirer.</p>



<p><strong>Modifications to the Privacy Policy</strong></p>



<p>PWL may change this Privacy Policy from time to time. If changes are made, we will email clients who have given us permission to do so. Generally, as a regular course of business and for ease of reference, we will post any change to the policy on our website. However, please be assured that if the Privacy Policy changes in the future, we will not use the personal information you have submitted to us under this Privacy Policy in a manner that is materially inconsistent with the revised Privacy Policy, without your prior consent.</p>



<p>If you believe that our Privacy Policy does not adequately address your privacy concerns or if you wish to discuss the treatment of your personal information please contact us at 1-876-908-3800 or e-mail us at info@provenwealth.com.</p>



<p><strong>Implemented on: October 17, 2018.</strong></p>
                    </div>
  ''';
}
