export default {
  async fetch(request) {
    const gke = "http://gke.multicloudjeena.site";
    const eks = "http://eks.multicloudjeena.site/";

    async function check(url) {
      try {
        const res = await fetch(url, { redirect: "follow" });
        if (res.status >= 200 && res.status < 400) return res;
      } catch (err) {}
      return null;
    }

    const gkeRes = await check(gke);
    if (gkeRes) return gkeRes;

    const eksRes = await check(eks);
    if (eksRes) return eksRes;

    return new Response("Both clusters DOWN", { status: 503 });
  }
}


