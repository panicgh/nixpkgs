{ lib
, buildPythonPackage
, click
, cython_3
, fetchFromGitHub
, jieba
, joblib
, lmdb
, marisa-trie
, mwparserfromhell
, numpy
, pythonOlder
, scipy
, setuptools
, tqdm
}:

buildPythonPackage rec {
  pname = "wikipedia2vec";
  version = "2.0.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "wikipedia2vec";
    repo = "wikipedia2vec";
    rev = "refs/tags/v${version}";
    hash = "sha256-vrBLlNm0bVIStSBWDHRCtuRpazu8JMCtBl4qJPtHGvU=";
  };

  nativeBuildInputs = [
    cython_3
    setuptools
  ];

  propagatedBuildInputs = [
    click
    cython_3
    jieba
    joblib
    lmdb
    marisa-trie
    mwparserfromhell
    numpy
    scipy
    tqdm
  ];

  preBuild = ''
    bash cythonize.sh
  '';

  pythonImportsCheck = [
    "wikipedia2vec"
  ];

  meta = with lib; {
    description = "Tool for learning vector representations of words and entities from Wikipedia";
    homepage = "https://wikipedia2vec.github.io/wikipedia2vec/";
    changelog = "https://github.com/wikipedia2vec/wikipedia2vec/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ derdennisop ];
  };
}
