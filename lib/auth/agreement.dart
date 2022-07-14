import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xffEFF1F5),
        appBar: AppBar(
          backgroundColor: Constant.mainColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("agreement")
                .doc("agreement")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return CircularProgressIndicator();
              else
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      child: Stack(
                        children: [
                          Container(
                              // height: 450,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: '${snapshot.data["photo"]}' == null
                                        ? AssetImage(
                                            "assets/images/cube.png",
                                          )
                                        : NetworkImage(
                                            '${snapshot.data["photo"]}')),
                              )),
                          Container(
                            // height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Constant.mainColor.withOpacity(0.5),
                                Constant.mainColor.withOpacity(0.7),
                                // Colors.white,
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '${snapshot.data["content"]}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
            },
          ),
        ));
  }
}

const khtmll = """ <p><strong><u>Victory Chapel App </u></strong></p>
<p><strong><u>PRIVACY POLICY</u></strong></p>
<p>&nbsp;</p>
<ol start="1">
  </ol>
<p>&nbsp;</p>
<ol start="2">
<li>Victory Chapel App may change this policy from time to time. Changes to our policy will be updated on our Apps, Websites and/or Services only. You should check our policy from time to time to ensure that you are happy with any modifications. This policy was last updated on 24 October 2017.</li>
</ol>
<ol start="3">
<li>Victory Chapel App will be uploading your personal information to an our external api - https://api.Alumates Blog/</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>WHAT INFORMATION WE COLLECT</u></strong></p>
<p>&nbsp;</p>
<ol start="4">
<li>We may collect the following information:</li>
</ol>
<p>&nbsp;</p>
<ul>
<li>Name and job title</li>
<li>Gender and date of birth</li>
<li>Contact information including telephone number and email address</li>
<li>Demographic information such as postcode, preferences and interests</li>
<li>Other information required or relevant to registration for our events and/or products</li>
<li>Other information relevant to customer surveys and/or offers</li>
</ul>
<p>&nbsp;</p>
<p><strong><u>Victory Chapel App USER</u></strong></p>
<p>&nbsp;</p>
<ol start="5">
<li>In order to become an Victory Chapel App User, you must provide us the following information to create an account: first name, last name, email address and password. Without this minimal amount of information, you cannot create an account. Victory Chapel App may request other information from you during the account creation process, (e.g., gender, location, etc.) that Victory Chapel App uses to provide better, more customized marketing services such as updates, better ads, and more valuable information. You acknowledge that this information is personal to you, and by creating an account on our websites; you allow Victory Chapel App and selected third parties, to identify you and to allow to use your information in accordance with our User Agreement.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>COOKIES</u></strong></p>
<p>&nbsp;</p>
<ol start="6">
<li>Like most applications, we use cookies and web log files to track site usage and trends, to improve the quality of our service, to customize your experience on our Websites and Services, as well as to deliver Victory Chapel App and third-party advertising to Site Users and Victory Chapel App Users both on and off our Websites and Services. A cookie is a tiny data file that resides on your computer, mobile phone, or other device, and allows us to recognize you as an Victory Chapel App User when you return to our Websites or Services using the same device. You can remove or block cookies using the settings in your device, but in some cases doing so may impact your ability to use our Websites or Services.</li>
</ol>
<p>&nbsp;</p>
<ol start="7">
<li>In the course of serving advertisements or optimizing the services to our Victory Chapel App Users, we may allow authorized third parties to place or recognize a unique cookie on your browser. Any information provided to third parties through cookies will not be personally identifiable but may provide general segment information (e.g. your industry or geography or information about your professional or educational background) for the enhancement of your user experience by providing more relevant advertising. Most browsers are initially set up to accept cookies, but you can reset your browser to refuse all cookies or to indicate when a cookie is being sent. Our Websites and Services do not store unencrypted personally identifiable information in the cookies.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>ADVERTISING</u></strong></p>
<p>&nbsp;</p>
<ol start="8">
<li>To support the services we provide at no cost to our Victory Chapel App Users, as well as provide a more relevant and useful experience for our Users, we target and serve our own ads and also ads from third-parties.</li>
</ol>
<p>&nbsp;</p>
<ol start="9">
<li>We target ads to Victory Chapel App Users based on general profile information or on non-personally identifiable information inferred from a User&rsquo;s profile (e.g. industry, school, gender, age, nationality, or other relevant information). Victory Chapel App does not provide personally identifiable information to any third party ad network.</li>
</ol>
<p>&nbsp;</p>
<ol start="9">
<li>Third party advertisers may use cookies to track the number of anonymous users responding to their campaigns. We will not have access to or control of cookies placed by third parties.</li>
</ol>
<p>&nbsp;</p>
<ol start="10">
<li>You have the ability to accept or decline cookies by modifying your browser preferences. You can accept all cookies, be notified when a cookie is set, or reject all cookies.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>RIGHTS TO ACCESS, CORRECT AND ELIMINATE INFORMATION ABOUT YOU</u></strong></p>
<p>&nbsp;</p>
<ol start="11">
<li>You have a right to access, modify, correct and eliminate the data you supplied to Victory Chapel App. If you update any of your information, we may keep a copy of the information that you originally provided to us in our archives for uses documented in this policy. You may amend your information by logging onto the App or Service and accessing your user profile. You may delete your account either by logging onto the App or Service and accessing your user profile or you may request deletion of your information at any time by contacting support@Alumates Blog. We will respond to your request within 30 days. Please note, however, that we may retain some anonymised information for site statistics and internal use and that information you have shared with others, or that other Victory Chapel App Users have copied, may also remain visible even if you request its deletion.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>DATA RETENTION</u></strong></p>
<p>&nbsp;</p>
<ol start="12">
<li>Victory Chapel App will retain your information for so long as your account is active or as needed to provide you our Services. We will retain and use your information as necessary to comply with our legal obligations, resolve disputes, and enforce this Agreement.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>WHAT WE DO WITH THE INFORMATION WE GATHER</u></strong></p>
<p>&nbsp;</p>
<ol start="13">
<li>By providing information to Victory Chapel App for the purposes of becoming a User, creating your Victory Chapel App User account or adding any additional details to your Victory Chapel App User profile, you are expressly and voluntarily accepting the terms and conditions of this Privacy Policy and Victory Chapel App&rsquo; User Agreement that allow Victory Chapel App to process information about you.</li>
</ol>
<p>&nbsp;</p>
<ol start="14">
<li>Supplying information to Victory Chapel App, including any information deemed &ldquo;sensitive&rdquo; by applicable law, is entirely voluntary on your part. You have the right to withdraw your consent to Victory Chapel App&rsquo; collection and processing of your information at any time, in accordance with the terms of this Privacy Policy and the User Agreement, by changing your Settings, or by closing your account, but please note that your withdrawal of consent will not be retroactive.</li>
</ol>
<p>&nbsp;</p>
<ol start="15">
<li>We require this information to understand your needs and provide you with a better service, and in particular for the following reasons:</li>
</ol>
<p>&nbsp;</p>
<ul>
<li>Victory Chapel App Communications</li>
</ul>
<p>&nbsp;</p>
<ul>
<li>Internal record keeping</li>
</ul>
<p>&nbsp;</p>
<ul>
<li>To enhance our products and service we may periodically send promotional email about new.dart products, special offers or other information which we think you may find interesting using the email address which you have provided</li>
</ul>
<p>&nbsp;</p>
<ul>
<li>From time to time, we may also use your information to contact you for market research purposes.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li>We may contact you by email, phone, text or mail.</li>
</ul>
<p>&nbsp;</p>
<ul>
<li>We may use the information to customize the Apps, Websites or Services according to demographic interests.</li>
</ul>
<p>&nbsp;</p>
<p><strong><u>LINKS TO OTHER WEBSITES</u></strong></p>
<p>&nbsp;</p>
<ol start="22">
<li>Our Apps, Websites or Services may contain links to other websites of interest. However, once you have used these links to leave our site, you should note that we do not have any control over that other website. Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst visiting such sites and such sites are not governed by this privacy statement. You should exercise caution and look at the privacy statement applicable to the website in question.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>CONTROLLING YOUR PERSONAL INFORMATION</u></strong></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<ol start="23">
<li>You may choose to restrict the collection or use of your personal information in the following ways:</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>When you are asked to fill in a form on any of our Websites or Services, look for the tick box(es) that indicate(s) you do not want the information to be used for direct marketing purposes.</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>If you have previously agreed to us using your personal information for direct marketing purposes, you may change your mind at any time either by amending your user profile or by sending an email to support@Alumates Blog and stating that you would like to be removed from our marketing lists.</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>To remove yourself from email communications, you can either amend your user profile or you can send an email to support@Alumates Blog stating that you would like to be removed from our marketing lists.</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>You may request details of personal information which we hold about you under the Data Protection Act. A small fee will be payable. If you would like a copy of the information held on you please write to support@Alumates Blog.</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>If you believe that any information we are holding on you is incorrect or incomplete, please write to us or email us as soon as possible, at the above address. We will promptly correct any information found to be incorrect.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>SECURITY</u></strong></p>
<p>&nbsp;</p>
<ol start="24">
<li>We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure, we safeguard and secure the information we collect online via electronic and managerial procedures.</li>
</ol>
<p>&nbsp;</p>
<ol start="25">
<li>To protect any data you store on our servers, Victory Chapel App also regularly audits its system for possible vulnerabilities and attacks. However, since the internet is not a 100% secure environment, we cannot ensure or warrant the security of any information you transmit to Victory Chapel App. There is no guarantee that information may not be accessed, disclosed, altered, or destroyed by breach of any of our physical, technical, or managerial safeguards.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>YOUR OBLIGATIONS</u></strong></p>
<p>&nbsp;</p>
<ol start="27">
<li>As an Victory Chapel App User, you have certain obligations to other Victory Chapel App Users. Some of these obligations are imposed by applicable law and regulations, and others have become commonplace in user-friendly communities of like-minded members such as Victory Chapel App:</li>
</ol>
<p>&nbsp;</p>
<ol start="28">
<li>You must, at all times, abide by the terms and conditions of the then-current Privacy Policy and User Agreement. This includes respecting all intellectual property rights that may belong to third parties (such as trademarks or photographs).</li>
</ol>
<p>&nbsp;</p>
<ol start="29">
<li>You must not download or otherwise disseminate any information that may be deemed to be injurious, violent, offensive, racist or xenophobic, or which may otherwise violate the purpose and spirit of Victory Chapel App and its community.</li>
</ol>
<p>&nbsp;</p>
<ol start="30">
<li>You must not provide to Victory Chapel App and/or other Site Users and/or Victory Chapel App Users information that you believe might be injurious or detrimental to your person or to your professional or social status.</li>
</ol>
<p>&nbsp;</p>
<ol start="31">
<li>You must keep your password confidential and not share it with others.</li>
</ol>
<p>&nbsp;</p>
<ol start="32">
<li>Any violation of these guidelines may lead to the restriction, suspension or termination of your account at the sole discretion of Victory Chapel App.</li>
</ol>
<p>&nbsp;</p>
<p><strong><u>HOW TO CONTACT US</u></strong></p>
<p>&nbsp;</p>
<ol start="33">
<li>You may also write to us with any questions or concerns about this Privacy Policy at:</li>
</ol>
<p>&nbsp;</p>
<p>Victory Chapel App Uyo:</p>
<p>Abuja,</p>
<p>Nigeria</p> """;
