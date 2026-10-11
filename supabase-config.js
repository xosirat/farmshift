/* Public client configuration only. Safe to publish the Supabase anon/publishable key when Row Level Security is enabled.
   Never put a Supabase service_role key or Cloudflare Turnstile secret in this file. */
window.FARMSHIFT_CONFIG = {
  supabaseUrl: "https://YOUR_PROJECT_REF.supabase.co",
  supabaseAnonKey: "YOUR_PUBLIC_SUPABASE_ANON_KEY",
  turnstileSiteKey: "YOUR_CLOUDFLARE_TURNSTILE_SITE_KEY"
};
