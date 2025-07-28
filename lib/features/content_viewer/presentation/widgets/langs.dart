import 'package:highlight/highlight.dart' as hl;
import 'package:highlight/languages/dart.dart' as l_dart;
import 'package:highlight/languages/javascript.dart' as l_js;
import 'package:highlight/languages/typescript.dart' as l_ts;
import 'package:highlight/languages/python.dart' as l_py;
import 'package:highlight/languages/java.dart' as l_java;
import 'package:highlight/languages/cpp.dart' as l_cpp;
import 'package:highlight/languages/cs.dart' as l_cs;
import 'package:highlight/languages/go.dart' as l_go;
import 'package:highlight/languages/kotlin.dart' as l_kotlin;
import 'package:highlight/languages/swift.dart' as l_swift;
import 'package:highlight/languages/rust.dart' as l_rust;
import 'package:highlight/languages/php.dart' as l_php;
import 'package:highlight/languages/shell.dart' as l_sh;
import 'package:highlight/languages/yaml.dart' as l_yaml;
import 'package:highlight/languages/json.dart' as l_json;
import 'package:highlight/languages/xml.dart' as l_xml;
import 'package:highlight/languages/css.dart' as l_css;
import 'package:highlight/languages/markdown.dart' as l_md;
import 'package:path/path.dart' as p;

hl.Mode? languageForPath(String path) {
  final ext = p.extension(path).toLowerCase();
  switch (ext) {
    case '.dart':
      return l_dart.dart;
    case '.js':
      return l_js.javascript;
    case '.ts':
      return l_ts.typescript;
    case '.py':
      return l_py.python;
    case '.java':
      return l_java.java;
    case '.cpp':
    case '.cc':
    case '.cxx':
    case '.hpp':
    case '.hh':
    case '.hxx':
    case '.c':
    case '.h':
      return l_cpp.cpp;
    case '.cs':
      return l_cs.cs;
    case '.go':
      return l_go.go;
    case '.kt':
    case '.kts':
      return l_kotlin.kotlin;
    case '.swift':
      return l_swift.swift;
    case '.rs':
      return l_rust.rust;
    case '.php':
      return l_php.php;
    case '.sh':
    case '.bash':
      return l_sh.shell;
    case '.yml':
    case '.yaml':
      return l_yaml.yaml;
    case '.json':
      return l_json.json;
    case '.xml':
      return l_xml.xml;
    case '.html':
      // В пакете нет languages/html.dart – используем xml как близкую подсветку.
      return l_xml.xml;
    case '.css':
      return l_css.css;
    case '.md':
      return l_md.markdown;
    default:
      return null; // без подсветки
  }
}
