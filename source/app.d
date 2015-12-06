import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;

shared static this()
{
	auto router = new URLRouter;
	router.get("/", staticTemplate!"index.dt");
	router.get("*", serveStaticFiles("public"));

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["127.0.0.1"];
	listenHTTP(settings, router);
}
