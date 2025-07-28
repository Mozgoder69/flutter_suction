import 'package:flutter/foundation.dart';

void logI(String message) => debugPrint('[INFO] $message');
void logW(String message) => debugPrint('[WARN] $message');
void logE(Object error, [StackTrace? st]) =>
    debugPrint('[ERR ] $error\n${st ?? StackTrace.current}');
