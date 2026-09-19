import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Affiche une page de e-gospel.com dans l'application.
///
/// Gère 3 états : chargement (avec barre de progression réelle),
/// contenu affiché, erreur réseau — important pour une bonne
/// expérience sur les connexions parfois lentes/instables.
class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppConfig.colorWhite)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _hasError = false;
              _progress = 0;
            });
          },
          onProgress: (progress) {
            if (!mounted) return;
            setState(() => _progress = progress / 100);
          },
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() => _isLoading = false);
          },
          onWebResourceError: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _progress = 0;
    });
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      appBar: AppBar(
        backgroundColor: AppConfig.colorWhite,
        elevation: 0.5,
        foregroundColor: AppConfig.colorBlack,
        title: Text(
          widget.title.isNotEmpty ? widget.title : AppConfig.appName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _hasError ? _retry : () => _controller.reload(),
          ),
          IconButton(
            tooltip: 'Ouvrir dans le navigateur',
            icon: const Icon(Icons.open_in_new_rounded, size: 20),
            onPressed: () =>
                WebNavigationService.openInExternalBrowser(widget.url),
          ),
        ],
        bottom: _isLoading && !_hasError
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: LinearProgressIndicator(
                  value: _progress > 0 ? _progress : null,
                  minHeight: 2,
                  backgroundColor: AppConfig.colorBorder,
                  color: AppConfig.colorOrange,
                ),
              )
            : null,
      ),
      body: Stack(
        children: [
          if (!_hasError) WebViewWidget(controller: _controller),
          if (_isLoading && !_hasError)
            const Center(
              child: CircularProgressIndicator(
                color: AppConfig.colorOrange,
              ),
            ),
          if (_hasError) _buildErrorState(),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: AppConfig.colorBlack),
            const SizedBox(height: 16),
            const Text(
              'Impossible de charger la page.\nVérifiez votre connexion Internet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppConfig.colorBlack, fontSize: 15),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.colorOrange,
                foregroundColor: AppConfig.colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Réessayer'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  WebNavigationService.openInExternalBrowser(widget.url),
              child: const Text(
                'Ouvrir dans le navigateur',
                style: TextStyle(color: AppConfig.colorBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
