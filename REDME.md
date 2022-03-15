# Remote Selenium Chrome Browser

# Selenium

Run script that open browser
```
ruby selenium.rb
```
When there is no `url` option, it will use local selenium (from gems).
For local selenium from gems all three browser works fine. Safari is the
fastest, but Chrome and Firefox return only the text from body (not all js).

Let's try to start selenium server https://www.selenium.dev/documentation/grid/getting_started/
```
java -jar ~/Programs/selenium-server-4.1.2.jar standalone
```
This can be local or remote mashine.
You can see that it is started on http://localhost:4444/

Now run script with enabled `url` option
```
# uncomment with url: "http://localhost:4444/wd/hub"
ruby selenium.rb
```
For selenium from java initially only Safari works since it can access safari
driver. To enable chrome and firefox you need to add PATH before running the
java command (since it will use drivers to start browsers).
```
which safaridriver 
/usr/bin/safaridriver

export PATH=$PATH:~/.webdrivers
which chromedriver
/Users/dule/.webdrivers/chromedriver
which geckodriver
/Users/dule/.webdrivers/geckodriver

java -jar ~/Programs/selenium-server-4.1.2.jar standalone
```

3th way to start selenium is with Docker
https://github.com/SeleniumHQ/docker-selenium
```
docker run -p 4444:4444 -p 7900:7900 --shm-size="2g" selenium/standalone-firefox:4.1.2-20220217
```
Here drivers are included inside machine on which you can vnc
http://localhost:7900/vnc.html?password=secret&autoconnect=true&reconnect=true&resize=scale
or open `-p 5900:5900` if you want to use another VNC Viewer.

# Log

```
docker run -p 4444:4444 -p 7900:7900 --shm-size="2g" selenium/standalone-firefox:4.1.2-20220217
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
2022-03-15 09:39:28,020 INFO Included extra file "/etc/supervisor/conf.d/selenium.conf" during parsing
2022-03-15 09:39:28,026 INFO supervisord started with pid 12
2022-03-15 09:39:29,057 INFO spawned: 'xvfb' with pid 18
2022-03-15 09:39:29,069 INFO spawned: 'vnc' with pid 20
2022-03-15 09:39:29,076 INFO spawned: 'novnc' with pid 22
2022-03-15 09:39:29,084 INFO spawned: 'selenium-standalone' with pid 24
Setting up SE_NODE_GRID_URL...
2022-03-15 09:39:29,268 INFO success: xvfb entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
2022-03-15 09:39:29,268 INFO success: vnc entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
2022-03-15 09:39:29,269 INFO success: novnc entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
2022-03-15 09:39:29,269 INFO success: selenium-standalone entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
Selenium Grid Standalone configuration:
[network]
relax-checks = true

[node]
session-timeout = "300"
override-max-sessions = false
detect-drivers = false
max-sessions = 1

[[node.driver-configuration]]
display-name = "firefox"
stereotype = '{"browserName": "firefox", "browserVersion": "97.0", "platformName": "Linux"}'
max-sessions = 1

Starting Selenium Grid Standalone...
09:39:31.951 INFO [LoggingOptions.configureLogEncoding] - Using the system default encoding
09:39:31.974 INFO [OpenTelemetryTracer.createTracer] - Using OpenTelemetry for tracing
09:39:35.097 INFO [NodeOptions.getSessionFactories] - Detected 4 available processors
09:39:35.330 INFO [NodeOptions.report] - Adding firefox for {"browserVersion": "97.0","browserName": "firefox","platformName": "Linux","se:vncEnabled": true} 1 times
09:39:35.391 INFO [Node.<init>] - Binding additional locator mechanisms: name, relative, id
09:39:35.524 INFO [LocalDistributor.add] - Added node 95abd0bc-ed52-4efe-b834-503a093cc43c at http://172.17.0.2:4444. Health check every 120s
09:39:35.585 INFO [GridModel.setAvailability] - Switching node 95abd0bc-ed52-4efe-b834-503a093cc43c (uri: http://172.17.0.2:4444) from DOWN to UP
09:39:36.692 INFO [Standalone.execute] - Started Selenium Standalone 4.1.2 (revision 9a5a329c5a): http://172.17.0.2:4444
```

I can access http://localhost:4444/ui/index.html#/ or using `telnet localhost
4444` (escape is ctrl + ] and ctrl + d).

For running `ruby selenium.rb` I see logs `session request received`,
`marionette enabled, listening and stop listening`, `session created` and
`deleted session`.
```
09:41:10.730 INFO [LocalDistributor.newSession] - Session request received by the distributor:
 [Capabilities {browserName: firefox}]
1647337270905	geckodriver	INFO	Listening on 127.0.0.1:39815
1647337272259	mozrunner::runner	INFO	Running command: "/usr/bin/firefox" "--marionette" "-no-remote" "-profile" "/tmp/rust_mozprofileG1uoiw"
[GFX1-]: glxtest: libpci missing
[GFX1-]: glxtest: libEGL missing
1647337275998	Marionette	INFO	Marionette enabled
console.warn: SearchSettings: "get: No settings file exists, new profile?" (new NotFoundError("Could not open the file at /tmp/rust_mozprofileG1uoiw/search.json.mozlz4", (void 0)))
1647337291555	Marionette	INFO	Listening on port 35523
09:41:32.518 INFO [ProtocolHandshake.createSession] - Detected dialect: W3C
09:41:32.673 INFO [LocalDistributor.newSession] - Session created by the distributor. Id: 0eedcd0b-4f08-45e9-84c4-e23a9936a163, Caps: Capabilities {acceptInsecureCerts: false, browserName: firefox, browserVersion: 97.0.1, moz:accessibilityChecks: false, moz:buildID: 20220216172458, moz:geckodriverVersion: 0.30.0, moz:headless: false, moz:processID: 331, moz:profile: /tmp/rust_mozprofileG1uoiw, moz:shutdownTimeout: 60000, moz:useNonSpecCompliantPointerOrigin: false, moz:webdriverClick: true, pageLoadStrategy: normal, platformName: linux, platformVersion: 5.10.76-linuxkit, proxy: Proxy(), se:cdp: ws://172.17.0.2:4444/sessio..., se:vnc: ws://172.17.0.2:4444/sessio..., se:vncEnabled: true, se:vncLocalAddress: ws://172.17.0.2:7900, setWindowRect: true, strictFileInteractability: false, timeouts: {implicit: 0, pageLoad: 300000, script: 30000}, unhandledPromptBehavior: dismiss and notify}
1647337307260	Marionette	INFO	Stopped listening on port 35523
09:41:50.579 INFO [LocalSessionMap.lambda$new$0] - Deleted session from local session map, Id: 0eedcd0b-4f08-45e9-84c4-e23a9936a163
```

# Errors

When server is not started, you can see error `Errno::ECONNREFUSED` or `end of file
reached (EOFError)`
```
net/http.rb:987:in `initialize': Connection refused - connect(2) for "localhost" port 4444 (Errno::ECONNREFUSED)
```

It is important to call `driver.quit` or `browser.close` (`marionette stoped
listening` and `deleted session` logs are missing) since when I run two
times `ruby selenium.rb` the second time when I run it I see an
`Net::ReadTimeout` error. It works fine if I restart selenium server (manually
closing the browser inside vnc does not help).
```
/Users/dule/.rvm/gems/ruby-3.0.1/gems/net-protocol-0.1.2/lib/net/protocol.rb:219:in `rbuf_fill': Net::ReadTimeout with #<TCPSocket:(closed)> (Net::ReadTimeout)
	from /Users/dule/.rvm/gems/ruby-3.0.1/gems/net-protocol-0.1.2/lib/net/protocol.rb:193:in `readuntil'
```
Same error `Net::ReadTimeout` is when I request `:chrome` but docker
`standalone-firefox` image is running (no logs on docker side).

To automatically kill stale sessions (default is 300seconds) you can use
https://github.com/SeleniumHQ/docker-selenium#grid-url-and-session-timeout
https://stackoverflow.com/questions/45591976/how-to-terminate-session-in-selenium-gridextras
```
docker run -p 4444:4444 -p 7900:7900 --net grid -e SE_NODE_SESSION_TIMEOUT=10 --shm-size="2g" selenium/standalone-firefox
```
This autoclose stale sessions works find for seleniarm/standalone-chromium

but for firefore after 10 seconds I see error in java
```
Unable to drain process streams. Ignoring but the exception being swallowed follows.
org.apache.commons.exec.ExecuteException: The stop timeout of 2000 ms was exceeded (Exit value: -559038737)
	at org.apache.commons.exec.PumpStreamHandler.stopThread(PumpStreamHandler.java:295)
	...
10:20:22.527 ERROR [OsProcess.destroy] - Unable to kill process Process[pid=310, exitValue=143]
10:20:22.577 INFO [LocalSessionMap.lambda$new$0] - Deleted session from local session map, Id: ff8432f3-477f-424b-8238-399006b62b86
```
and I see this error on ruby side:

```
/Users/dule/.rvm/rubies/ruby-2.6.8/lib/ruby/2.6.0/net/protocol.rb:225:in `rbuf_fill': end of file reached (EOFError)
...
	from /Users/dule/.rvm/gems/ruby-2.6.8/gems/selenium-webdriver-4.1.0/lib/selenium/webdriver/remote/http/default.rb:124:in `response_for'
```
so since there is a problem with 4444 ie java is crashed (I can not `telnet
localhost 4444`) the best is to restart the docker image.

# Chrome

```
docker run --rm -it -p 4444:4444 -p 5900:5900 -p 7900:7900 --shm-size 3g seleniarm/standalone-chromium:latest
```
Running remote chrome needs to disable dev tools since there is an error
```
Error while creating session with the driver service. Stopping driver service: Could not start a new session. Response code 500. Message: unknown error: DevToolsActivePort file doesn't exist
Error while creating session with the driver service. Stopping driver service: Could not start a new session. Response code 500. Message: chrome not reachable
```
and mac M1 is not supported yet
https://github.com/SeleniumHQ/selenium/issues/10174#issuecomment-1000912090
so I had to use https://github.com/seleniumhq-community/docker-seleniarm
```
```
so I added `--disable-dev-shm-usage`
https://bugs.chromium.org/p/chromedriver/issues/detail?id=2473#c12


# Watir

Start using http://watir.com and read docs on http://watir.com/guides/
Find elements http://watir.com/guides/locating/

You can call
* `el.present?`
* `el.click`
* `el.text == "A"`
* `el.attribute`
