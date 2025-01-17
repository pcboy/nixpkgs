{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  flit-core,
  pythonOlder,
  defusedxml,
  docutils,
  jinja2,
  markdown-it-py,
  mdit-py-plugins,
  pyyaml,
  sphinx,
  typing-extensions,
  beautifulsoup4,
  pytest-param-files,
  pytest-regressions,
  sphinx-pytest,
  pytestCheckHook,
}:
buildPythonPackage rec {
  pname = "myst-parser";
  version = "4.0.0";
  format = "pyproject";

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "executablebooks";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-QbFENC/Msc4pkEOPdDztjyl+2TXtAbMTHPJNAsUB978=";
  };

  build-system = [ flit-core ];

  dependencies = [
    docutils
    jinja2
    mdit-py-plugins
    markdown-it-py
    pyyaml
    sphinx
    typing-extensions
  ];

  nativeCheckInputs = [
    beautifulsoup4
    defusedxml
    pytest-param-files
    pytest-regressions
    sphinx-pytest
    pytestCheckHook
  ] ++ markdown-it-py.optional-dependencies.linkify;

  disabledTests = [
    # sphinx 7.4 compat
    "test_gettext"
    "test_gettext_additional_targets"
    "test_amsmath"
  ];

  pythonImportsCheck = [ "myst_parser" ];

  pythonRelaxDeps = [ "docutils" ];

  meta = with lib; {
    description = "Sphinx and Docutils extension to parse MyST";
    homepage = "https://myst-parser.readthedocs.io/";
    changelog = "https://raw.githubusercontent.com/executablebooks/MyST-Parser/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ loicreynier ];
  };
}
