# Privacy Policy for Sukoon

**Last updated: June 4, 2026**

This Privacy Policy describes how Sukoon ("we", "our", "the app") handles your information when you use our mobile application. Sukoon is a prayer app for Muslims that provides prayer times, a qibla compass, a nearby-masjid finder, the Quran with audio, and an Islamic AI assistant.

We've kept this policy short and in plain language because we believe you shouldn't need a lawyer to understand what an app does with your data.

## TL;DR

- **Sukoon does not require an account.** We do not collect your name, email, phone number, or any personal identifiers.
- **Your location stays on your device** for prayer-time calculations. It is sent to Google Places only when you actively use the "Find Masjids" feature, so we can return nearby results.
- **Your prayer log, bookmarks, and preferences are stored only on your device.** They are not synced or uploaded.
- **Messages you send to the Islamic assistant are forwarded to OpenAI** to generate a response. They are not stored by us.
- **We do not sell your data. Ever.**

## Data we collect on-device only

The following stay on your phone and are never transmitted to our servers or anyone else:

- **Prayer logs** — which prayers you marked as completed, used to compute your streak.
- **Quran bookmarks** — verses you've saved.
- **App preferences** — theme, calculation method, madhab, font size, tajweed toggle, etc.
- **AI assistant chat history** — past conversations are saved locally for your reference.

You can erase all of this by uninstalling the app or clearing its storage in your device settings.

## Data sent to third parties when you use specific features

### Location → Prayer time calculation (on-device)
Your device's location is used by the `adhan` library running on your phone to calculate the times of Fajr, Dhuhr, Asr, Maghrib, and Isha. **This calculation happens entirely on your device.** Your location is not transmitted to us.

### Location → Find Masjids (sent to Google Places)
When you tap "Find Masjids", your approximate location is sent to **Google Places API** so we can return mosques near you. Google's privacy policy applies to that request: https://policies.google.com/privacy

### Assistant messages → OpenAI via Cloudflare Worker
When you ask the Islamic assistant a question, your message is sent to a Cloudflare Worker we operate, which forwards it to **OpenAI's API** to generate a response. We do not log or store the contents of your messages on our servers. OpenAI's data usage policy applies to the message in transit: https://openai.com/policies/api-data-usage-policies

### Anonymous notifications
The app schedules local prayer-time notifications using Expo's local-notification system. These run on your device and do not involve any server.

## Advertising

Sukoon may show ads from **Google AdMob**. AdMob may collect a device-level advertising identifier and basic device information (operating system, language, country) to serve relevant ads. You can reset or limit this identifier in your device's privacy settings:
- Android: Settings → Privacy → Ads → Reset advertising ID / Opt out of personalized ads.

A future paid "Pro" version of Sukoon will remove ads entirely. Google AdMob's privacy practices are described at https://policies.google.com/technologies/ads

## Permissions

Sukoon requests the following Android permissions, used only for what's described:

- **Location (fine + coarse)** — for prayer-time calculation (on-device) and nearby-masjid search (Google Places).
- **Notifications** — to remind you when each prayer time arrives.

You can revoke either permission at any time in Android Settings → Apps → Sukoon → Permissions. The relevant feature will gracefully stop working but the rest of the app continues to function.

## Children

Sukoon is intended for users aged 13 and above. We do not knowingly collect personal data from children under 13.

## Changes to this policy

If we change this policy, we'll update the "Last updated" date at the top. Significant changes will be reflected in a release note in the app.

## Contact

If you have questions about your privacy or this policy, email:

**qureshi.hussain@gmail.com**
