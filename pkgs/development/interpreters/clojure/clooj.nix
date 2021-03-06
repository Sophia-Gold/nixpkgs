{ stdenv, fetchurl, jre, makeWrapper }:

let version = "0.4.4"; in

stdenv.mkDerivation {
  name = "clooj-${version}";

  jar = fetchurl {
    url = "http://download1492.mediafire.com/5bbi05sxgxog/prkf64humftrmz3/clooj-0.4.4-standalone.jar";
    sha256 = "0hbc29bg2a86rm3sx9kvj7h7db9j0kbnrb706wsfiyk3zi3bavnd";
  };

  buildInputs = [ makeWrapper ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/share/java
    ln -s $jar $out/share/java/clooj.jar
    makeWrapper ${jre}/bin/java $out/bin/clooj --add-flags "-jar $out/share/java/clooj.jar"
  '';

  meta = {
    description = "A lightweight IDE for Clojure";
    homepage = https://github.com/arthuredelstein/clooj;
    license = stdenv.lib.licenses.bsd3;
  };
}
