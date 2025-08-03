/**
 * Compatability functions with cubari.moe and Tachiyomi's expected URL layout.
 */

export const mangaUrlBuilder = (url) => {
  return () => {
    return url && url.startsWith("/") ? `https://cubari.gabjimmy.com${url}` : url;
  };
};

export const mangaUrlSaver = (url) => {
  return (url || "").replace("https://cubari.gabjimmy.com", "");
};
