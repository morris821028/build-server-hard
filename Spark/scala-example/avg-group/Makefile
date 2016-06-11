all: jar

compile:
	sbt compile

run:
	sbt run

jar:
	@echo "At first time, it will need 5 ~ 7 minutes to find library dependency and download plugin into ~/.ivy2 or ~/.m2 or ~/.sbt."
	sbt package

clean:
	rm -r target project
	
