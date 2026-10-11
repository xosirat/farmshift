# FarmShift 🌱🛰️

FarmShift is a minimal, farmer-first prototype for the 2026 NASA Space Apps Challenge challenge **Field Shift: Adapting Farms with NASA Data**.

## Current prototype

- Clean, Pinterest-inspired card layout
- Location search and browser geolocation
- 10-day weather forecast through Open-Meteo
- NASA POWER recent meteorological context
- Transparent crop-rotation heuristic using water, soil, heat, weather and diversity signals
- NASA Worldview launch point
- 13-language selector with full-page translation widget
- Supabase Auth integration (email/password, email confirmation and password reset; requires provider setup)
- Cloudflare Turnstile CAPTCHA integration (requires provider-side secret configuration)
- Per-user cloud workspace sync with PostgreSQL Row Level Security (SQL schema included; requires Supabase setup)
- Guest mode remains available without an account
- Farmer assistant chat UI
- Field-photo preview
- Static, dependency-free app: no npm or build step

## Secure accounts and translation setup

The account UI is wired to Supabase Auth, Cloudflare Turnstile and a private per-user cloud-data table, but **it is not active until provider credentials are configured**. Follow [`SETUP.md`](SETUP.md) step by step and run [`supabase/schema.sql`](supabase/schema.sql) in the Supabase SQL Editor. Only the public Supabase URL/anon key and Turnstile site key belong in `supabase-config.js`; never commit service-role or CAPTCHA secret keys.

The language selector includes Punjabi, Hindi, Bengali, Tamil, Telugu, Marathi, Gujarati, Kannada, Malayalam, Urdu, Odia and Assamese. Full-page translation uses a third-party browser translation widget and may require internet access; important farming and safety text still needs native-speaker review.

## Run

Serve `index.html` from a local HTTP server. This is preferable to opening it directly with `file://` because browser API requests can be restricted there.

## GitHub Pages

Open **Settings → Pages → Deploy from a branch → main → /(root)**. GitHub will publish the site from this repository.

## Data & scientific caution

The prototype uses NASA POWER for recent meteorological context and NASA Worldview as the Earth-observation entry point. Open-Meteo supplies the user-facing forecast. The rotation score is a transparent heuristic, **not a yield predictor or farming guarantee**.

Before presenting the system as agricultural advice, the rules should be validated with local agronomy guidance and stronger satellite/ground datasets.

## Roadmap

1. Add an interactive NASA GIBS layer and field boundary.
2. Add validated satellite soil-moisture and vegetation indicators.
3. Add local soil and crop-calendar datasets.
4. Connect the assistant to a secure AI backend.
5. Add optional field-photo analysis with explicit uncertainty.
6. Make every recommendation traceable: **NASA signal → farm signal → recommendation**.
