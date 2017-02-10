/*
 * App.hpp
 * Copyright (C) 2017  Belledonne Communications, Grenoble, France
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *  Created on: February 2, 2017
 *      Author: Ronan Abhamon
 */

#ifndef APP_H_
#define APP_H_

#include "../components/notifier/Notifier.hpp"
#include "AvatarProvider.hpp"
#include "DefaultTranslator.hpp"
#include "ThumbnailProvider.hpp"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlFileSelector>
#include <QQuickWindow>
#include <QSystemTrayIcon>

// =============================================================================

class App : public QApplication {
  Q_OBJECT;

public:
  QQmlEngine *getEngine () {
    return &m_engine;
  }

  Notifier *getNotifier () const {
    return m_notifier;
  }

  QQuickWindow *getCallsWindow () const;
  QQuickWindow *getMainWindow () const;

  bool hasFocus () const;

  Q_INVOKABLE QString locale () const {
    return m_locale;
  }

  static void init (int &argc, char **argv) {
    if (!m_instance) {
      // Instance must be exists before content.
      m_instance = new App(argc, argv);
      m_instance->initContentApp();
    }
  }

  static App *getInstance () {
    return m_instance;
  }

private:
  App (int &argc, char **argv);
  ~App () = default;

  void initContentApp ();

  void registerTypes ();
  void addContextProperties ();
  void setTrayIcon ();

  QQmlApplicationEngine m_engine;
  QQmlFileSelector *m_file_selector = nullptr;
  QSystemTrayIcon *m_system_tray_icon = nullptr;

  AvatarProvider m_avatar_provider;
  ThumbnailProvider m_thumbnail_provider;
  DefaultTranslator m_default_translator;
  QTranslator m_english_translator;

  Notifier *m_notifier = nullptr;
  QString m_locale = "en";

  static App *m_instance;
};

#endif // APP_H_