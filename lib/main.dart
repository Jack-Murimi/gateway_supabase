import 'package:flutter/material.dart';
import 'package:gateway_supabase/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://icnadwrfnnkdhnwyfvmt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljbmFkd3Jmbm5rZGhud3lmdm10Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY3ODM5NjQsImV4cCI6MjAzMjM1OTk2NH0.Y_V2FfISlc8KxQ03NzuwKcmOv9gwLLs0TCdTYj4SEvw',
  );
  runApp(
    const App(),
  );
}
