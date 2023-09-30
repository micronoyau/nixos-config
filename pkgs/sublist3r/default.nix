{ lib, fetchgit, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "sublist3r";
  version = "1.1";
  format = "setuptools";

  src = fetchgit {
    url = "https://github.com/aboul3la/Sublist3r";
    hash = "sha256-nrnb3jAIHw6WXR7VLNmi1YdfMBzHEIiMlGSbrvEi6Uc=";
    rev = "729d649ec5370730172bf6f5314aafd68c874124";
  };

  doCheck = false;

  propagatedBuildInputs = with python3Packages; [
    dnspython
    requests
  ];

  # Strange error if disabled (duplicate on same sublister file in store
  pythonCatchConflictsPhase = "true";

  meta = with lib; {
    description = "Fast subdomains enumeration tool for penetration testers";
    longDescription = ''
    About Sublist3r
    Sublist3r is a python tool designed to enumerate subdomains of websites using OSINT. It helps penetration testers and bug hunters collect and gather subdomains for the domain they are targeting. Sublist3r enumerates subdomains using many search engines such as Google, Yahoo, Bing, Baidu and Ask. Sublist3r also enumerates subdomains using Netcraft, Virustotal, ThreatCrowd, DNSdumpster and ReverseDNS.
    subbrute was integrated with Sublist3r to increase the possibility of finding more subdomains using bruteforce with an improved wordlist. The credit goes to TheRook who is the author of subbrute.
    '';
    homepage = "https://github.com/aboul3la/Sublist3r/tree/master";
    mainProgram = "sublist3r";
    license = licenses.gpl2;
    maintainers = with maintainers; [ aboul3la ];
  };
}
