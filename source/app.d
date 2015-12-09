import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;
import core.time : days;


shared static this()
{
	auto fssettings = new HTTPFileServerSettings;
	fssettings.maxAge = 7.days;

	auto router = new URLRouter;
	router.get("/", staticTemplate!"index.dt");
	router.get("*", serveStaticFiles("public", fssettings));

	auto settings = new HTTPServerSettings;
	settings.port = 8010;
	settings.bindAddresses = ["127.0.0.1"];
	listenHTTP(settings, router);
}

void getHome(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
	res.headers["Cache-Control: max-age=86400"];
	res.render!("index.dt");
}