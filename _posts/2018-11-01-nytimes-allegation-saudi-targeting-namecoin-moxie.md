---
layout: post
title: "New York Times' Allegation of Saudi Intelligence Targeting Namecoin Developer Is Consistent with 2013 Reporting by Moxie Marlinspike"
author: Jeremy Rand
tags: [News]
---

[The New York Times published what appears to be a highly interesting scoop](https://www.nytimes.com/2018/10/20/us/politics/saudi-image-campaign-twitter.html) on October 20, 2018.  The New York Times article alleges that the government behind the State Sponsored Actors attack on circa 40 Twitter users (most of whom, including me, were free software developers and privacy activists) was none other than Saudi Arabia.  Those of us who were [notified of the attack in 2015](https://www.state-sponsored-actors.org/) have been trying to find out more ever since, with no luck until now.

As a precaution against censorship risk, the relevant subsection of the article is reproduced below:

> A Suspected Mole Inside Twitter
>
> Twitter executives first became aware of a possible plot to infiltrate user accounts at the end of 2015, when Western intelligence officials told them that the Saudis were grooming an employee, Ali Alzabarah, to spy on the accounts of dissidents and others, according to five people briefed on the matter. They requested anonymity because they were not authorized to speak publicly.
>
> Mr. Alzabarah had joined Twitter in 2013 and had risen through the ranks to an engineering position that gave him access to the personal information and account activity of Twitter’s users, including phone numbers and I.P. addresses, unique identifiers for devices connected to the internet.
>
> The intelligence officials told the Twitter executives that Mr. Alzabarah had grown closer to Saudi intelligence operatives, who eventually persuaded him to peer into several user accounts, according to three of the people briefed on the matter.
>
> Caught off guard by the government outreach, the Twitter executives placed Mr. Alzabarah on administrative leave, questioned him and conducted a forensic analysis to determine what information he may have accessed. They could not find evidence that he had handed over Twitter data to the Saudi government, but they nonetheless fired him in December 2015.
>
> Mr. Alzabarah returned to Saudi Arabia shortly after, taking few possessions with him. He now works with the Saudi government, a person briefed on the matter said.
>
> A spokesman for Twitter declined to comment. Mr. Alzabarah did not respond to requests for comment, nor did Saudi officials.
>
> On Dec. 11, 2015, Twitter sent out safety notices to the owners of a few dozen accounts Mr. Alzabarah had accessed. Among them were security and privacy researchers, surveillance specialists, policy academics and journalists. A number of them worked for the Tor project, an organization that trains activists and reporters on how to protect their privacy. Citizens in countries with repressive governments have long used Tor to circumvent firewalls and evade government surveillance.
>
> “As a precaution, we are alerting you that your Twitter account is one of a small group of accounts that may have been targeted by state-sponsored actors,” the emails from Twitter said.

Before I go any further, it's important to remember that the New York Times's source for these claims appears to be anonymous intelligence officials, and caution is warranted when evaluating claims by anonymous intelligence officials (*cough cough Iraq cough cough*).

That said, let's assume for the purpose of argument that the New York Times's allegation is correct, and Saudi Arabia was behind the attack.  What's the motive?  It's certainly plausible that Saudi Arabia would have an interest in Tor developers, but how did I get targeted?  Between 2013 and 2015 (when Alzabarah allegedly worked at Twitter), there were three main things I was spending my time on:

1. Console game hacking research for my undergraduate honors thesis.  Highly unlikely that Saudi Arabia would care about this.
2. Machine learning, ranking, and privacy research for the YaCy search engine, which would later evolve into my master's thesis.  I suppose it's technically possible that Saudi Arabia would find this interesting (since censorship resistance and privacy are known to annoy the Saudi government), but this work was relatively low-profile (it was only discussed within my classes at my university, a couple of IRC channels with small audiences, and a couple of posts on the YaCy forum).  Furthermore, no code was publicly available during this time period (which probably decreased any possible Saudi interest), and YaCy was simply too immature to credibly be considered a threat at that time (and probably even now).
3. TLS PKI research for Namecoin.  Specifically, my fork of Moxie Marlinspike's Convergence (a tool for customizing TLS certificate validation in Firefox) was created in 2013, my TLS PKI research with Namecoin continued through the present day, and this research received a decent amount of public attention (including being presented at a poster session at Google's New York office in 2013, and being the subject of a fundraising campaign in 2014).

Yeah, about that last one.  It's pretty clearly the one that would be most likely to attract attention from a state-sponsored actor (since it prevents state actors from compromising TLS certificate authorities in order to intercept encrypted communications), but why Saudi Arabia?  I had been previously speculating that the involved state might be Iran, seeing as they've been publicly accused of compromising TLS certificate authorities in the past.  I was not aware of any similar cases where Saudi Arabia was caught doing this.

However, then I ran across [a highly interesting article from the aforementioned Moxie Marlinspike](https://moxie.org/blog/saudi-surveillance/) dated May 13, 2013.  Again, as a precaution against censorship risk, the relevant parts are reproduced below:

> Last week I was contacted by an agent of Mobily, one of two telecoms operating in Saudi Arabia, about a surveillance project that they’re working on in that country. Having published two reasonably popular MITM tools, it’s not uncommon for me to get emails requesting that I help people with their interception projects. I typically don’t respond, but this one (an email titled “Solution for monitoring encrypted data on telecom”) caught my eye.
>
> I was interested to know more about what they were up to, so I wrote back and asked. After a week of correspondence, I learned that they are organizing a program to intercept mobile application data, with specific interest in monitoring:
>
> * Mobile Twitter
> * Viber
> * Line
> * WhatsApp
>
> I was told that the project is being managed by Yasser D. Alruhaily, Executive Manager of the Network & Information Security Department at Mobily. The project’s requirements come from “the regulator” (which I assume means the government of Saudi Arabia). The requirements are the ability to both monitor and block mobile data communication, and apparently they already have blocking setup.
>
> [snip]
>
> One of the design documents that they volunteered specifically called out compelling a CA in the jurisdiction of the UAE or Saudi Arabia to produce SSL certificates that they could use for interception.
>
> [snip]
>
> Their level of sophistication didn’t strike me as particularly impressive, and their existing design document was pretty confused in a number of places, but Mobily is a company with over 5 billion in revenue, so I’m sure that they’ll eventually figure something out.

So, let's look at some things that I found notable about this:

* Saudi Arabia **was** interested in doing TLS interception via a malicious CA.  There's your motive.
* The email exchange between Mobily and Moxie about interest in doing TLS interception was in 2013, the same year that Alzabarah allegedly began working for Twitter.
* I don't know how long it's expected to take a "confused" and "[not] particularly impressive" development team at a well-funded telecom to design TLS interception infrastructure, but it seems totally plausible that this Mobily project, or related projects at other Saudi telecoms or the Saudi government, continued through a significant portion of Alzabarah's alleged employment at Twitter, possibly as late as when Alzabarah allegedly obtained access to user data in his engineering position at Twitter.
* Moxie is the original author of Convergence, but stopped maintaining it in 2012.  My fork was created in 2013, and by 2014 my fork was the only maintained fork (after Mike Kazantsev stopped maintaining his Convergence-Extra fork).  So anyone who was interested in Moxie's work with TLS may very well have also been aware of me.
* Surveillance of Twitter is specifically mentioned in the email exchange between Mobily and Moxie.

So, as far as I can tell, the New York Times's allegation that Saudi intelligence targeted my Twitter account seems to be quite consistent with the 2013 reporting by Moxie.

That said, there is an unexplained loose end.  Most major browsers implemented TLS certificate pinning since 2013, and certificate pinning would probably have made it quite obvious if Saudi Arabia were using rogue TLS certificates to intercept communications with a large site like Twitter.  Ditto for certificate transparency.  So, even if Saudi intelligence was pursuing this project in 2013, it would be surprising if they're still doing so.

If anyone has further information about the State Sponsored Actors attack, I strongly encourage you to share it with journalists.  In particular, anonymously sending primary source documents to WikiLeaks would be a highly beneficial action.
