# FarmShift 🌱🛰️

FarmShift is a minimal, farmer-first prototype for the 2026 NASA Space Apps Challenge challenge **Field Shift: Adapting Farms with NASA Data**.

## Current prototype

- Clean, Pinterest-inspired card layout
- Location search and browser geolocation
- 10-day weather forecast through Open-Meteo
- NASA POWER recent meteorological context
- Transparent crop-rotation heuristic using water, soil, heat, weather and diversity signals
- NASA Worldview launch point
- 8-language selector foundation
- Farmer assistant chat UI
- Field-photo preview
- Static, dependency-free app: no npm or build step

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
