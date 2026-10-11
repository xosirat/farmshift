# FarmShift secure accounts, CAPTCHA and cloud sync

FarmShift is hosted on GitHub Pages, so this repository cannot securely host server secrets. Account creation, password handling, sessions and the database are delegated to **Supabase Auth + Postgres**. CAPTCHA verification is performed by Supabase Auth using **Cloudflare Turnstile**. The public frontend configuration contains only public keys.

## Status and required one-time setup

The frontend integration is committed, but **real accounts and CAPTCHA will not work until you connect your own Supabase project and Turnstile site**. I cannot create resources inside your provider accounts or set their private secrets from this repository.

### 1. Create the Supabase project

1. Create a project at https://supabase.com/dashboard and keep its database password private.
2. Open **Project Settings → API** (or **Connect**) and copy the Project URL and the public anon/publishable key. Never use the `service_role` key in the browser.
3. In **SQL Editor**, run the full contents of [supabase/schema.sql](supabase/schema.sql). This creates a per-user cloud-data table with Row Level Security. Users can only read or change their own row.
4. In **Authentication → URL Configuration**, set the Site URL to `https://xosirat.github.io` and add these Redirect URLs:
   - `https://xosirat.github.io/farmshift/`
   - `https://xosirat.github.io/farmshift`
5. In **Authentication → Providers → Email**, enable email/password sign-in. For safer account ownership, leave email confirmation enabled. Configure SMTP if you need reliable production confirmation/reset email delivery.

### 2. Configure Cloudflare Turnstile CAPTCHA

1. Create a Turnstile widget at https://dash.cloudflare.com/ with the hostname `xosirat.github.io` allowed. For local testing, add `localhost` as well.
2. Copy its **site key** (public) and **secret key** (private).
3. In Supabase, open **Authentication → Security and Protection / CAPTCHA protection**, choose **Cloudflare Turnstile**, and paste the **secret key** there. Save it. This is the server-side verification step; a visible widget alone is not security.
4. Put the site key in `supabase-config.js` as described below. Do **not** put the Turnstile secret in GitHub or in this file.

### 3. Connect the public frontend

Edit `supabase-config.js` and replace the three placeholder values:
- `supabaseUrl`: your Supabase Project URL.
- `supabaseAnonKey`: the public anon/publishable key.
- `turnstileSiteKey`: the public Turnstile site key.

Commit the public configuration file, then wait for GitHub Pages to publish. Public URL and anon key are intended for browser use **only when RLS is enabled**. Do not commit passwords, database connection strings, service-role keys, or CAPTCHA secret keys.

### 4. Test before sharing

- Create an account with an email you can access; confirm it if requested.
- Sign in, change a workspace field or language, and wait a moment for sync.
- Open FarmShift in another browser/device and sign in to check restoration.
- Test password reset, invalid CAPTCHA, and sign-out.
- Check Supabase Table Editor → `farmshift_user_data`; only your signed-in account should be able to access its row.

## What the integration does

- Email/password signup and sign-in through Supabase Auth; password reset emails.
- Session persistence managed by Supabase's client SDK, not a custom local password store.
- Cloud saving of workspace form values, chosen language and selected location to a single per-user JSON row; edits are debounced before sync.
- Database Row Level Security ensures the authenticated user ID must match the row's `user_id`.
- Cloudflare Turnstile widget token is passed to Supabase Auth, which must be configured with the private secret for server-side validation.
- Guest mode continues to work without an account. Guest data remains in that browser; it is not cloud-synced.

## Regional language support

The language selector integrates Google Translate's full-page website translation for the listed Indian languages, with the existing native translations for the main navigation. Translation is supplied by a third-party browser widget, so wording, availability, dynamically generated content and RTL layout (Urdu) can vary. It is not a reviewed professional translation. For a production agriculture service, have agronomists/native speakers review critical instructions and safety wording.

## Important limitations

- This is an early student prototype, not a certified agricultural or government service.
- The synced payload currently stores workspace form values and preferences; it deliberately excludes passwords, email inputs and uploaded files. It does not yet sync photos, chat history, or live NASA/weather responses.
- Anyone who has not configured provider keys cannot create an account yet; guest mode remains available.
- Do not store Aadhaar numbers, bank credentials, payment details or other highly sensitive personal information in this prototype.
