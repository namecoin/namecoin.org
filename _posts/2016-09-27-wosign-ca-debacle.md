---
layout: post
title: WoSign Certificate Authority Debacle Underscores Urgent Need for Pluggable Certificate Verification
author: Jeremy Rand
tags: [News]
---

At Namecoin, we have been following with interest the scandal surrounding the certificate authority WoSign.

For some background information on WoSign's misdeeds, I suggest reading the following links:

* [Incidents involving the CA WoSign (Mozilla Security Policy mailing list)](https://groups.google.com/d/topic/mozilla.dev.security.policy/k9PBmyLCi8I)
* [CA:WoSign Issues (Mozilla wiki)](https://wiki.mozilla.org/CA:WoSign_Issues)
* [The story of how WoSign gave me an SSL certificate for GitHub.com (Stephen Schrauger)](https://www.schrauger.com/the-story-of-how-wosign-gave-me-an-ssl-certificate-for-github-com)
* [Do you trust StartCom?  (Itzhak Daniel)](https://archive.is/8bSp6)
* [WoSign and StartCom (Mozilla; hosted by Google Docs)](https://docs.google.com/document/d/1C6BlmbeQfn4a9zydVi2UvjBGv6szuSB4sMYUcVrR8vQ/mobilebasic)
* [Chinese CA WoSign faces revocation after issuing fake certificates of Github, Microsoft and Alibaba (Percy Alpha) (Warning: non-TLS link)](http://www.percya.com/2016/08/chinese-ca-wosign-faces-revocation.html)
* [WoSign's secret purchase of StartCom; WoSign threatened legal actions over the disclosure (Percy Alpha) (Warning: non-TLS link)](http://www.percya.com/2016/09/wosigns-secret-purchase-of-startcom.html)

It is without question that WoSign has **violated the trust** of everyone who relies on the CA system.  (In other words, just about everyone who uses the Internet.)  It is without question that they have violated this trust **repeatedly**.  And it is without question that their response has done the **exact opposite** of restoring that trust.

There is no way to know how many other malicious certificates have been issued by WoSign.  Since it is known that many intelligence agencies consider it their job to exploit CA's, it is prudent to assume that at least one intelligence agency has obtained malicious certificates from WoSign.  When intelligence agencies perform MITM attacks, **people get imprisoned, tortured, or killed**.  Literally.  This isn't a joke.

It would be understandable to argue that the safest thing to do to prevent such attacks is to **immediately revoke** WoSign's root CA certificates.  However, the browser vendors are refusing to do this.  As of this writing, more than a month after WoSign responded to the questions about its trustworthiness by recommending that attackers who have obtained malicious certificates should ask WoSign to have them revoked, WoSign is still a trusted CA, and the only resolution being recommended is only distrust newly issued certificates.  That means that previously issued malicious certificates will still be accepted.  Why is this the case?  For exactly the same reason that U.S. banks were not forced to shut down in 2008: WoSign, like the U.S. banks, asserted the "Too Big To Fail" privilege.  This line of thinking claims that causing some websites to go offline until the websites can get new certificates is worse than intelligence agencies being allowed to impersonate websites.  That is classic politics, and should have no place in a system where people's safety is on the line.

However, bashing political decisions isn't particularly productive, because politics' existence is a fact of human life.  It is much more productive to realize that the existence of this specific political problem -- the problem that untrusting CA's is costly and disruptive -- is technical in nature, and that we should be investigating ways to solve it at the technical level.  **Alternatives to the CA system are needed**.  Specifically, alternatives that possess more trust agility than the CA system, such as Perspectives and Convergence, or that use blockchain-based trust such as Namecoin.

The three systems mentioned above are, of course, not yet at the point where they can replace the CA system completely.  Why is this?  One major problem is that **browser vendors make it unnecessarily difficult** for users to voluntarily opt into replacements for the CA system.  As a result, developers who wish to experiment with CA replacements instead find themselves having to do what I referred to in my DWS 2016 talk as "witchcraft".  And Namecoin's solution is quite a bit safer (in my opinion) than what many other developers are doing.  (More information about how Namecoin's certificate interoperability system operates will be the topic of future blog posts.)

TLS implementation vendors (including browser vendors) should create **pluggable certificate validation API's**, so that developers of validation systems can focus on their system's trust properties.  The Internet needs to get off of the CA system and the politics that come with it, and we are not going to get there without technical experimentation being possible.
