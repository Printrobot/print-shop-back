package main

import (
    "calc-user-data-back-adm/config"
    "calc-user-data-back-adm/internal/app"
    "calc-user-data-back-adm/pkg/mrlang"
    "calc-user-data-back-adm/pkg/mrlib"
    "flag"
)

const appVersion = "v0.1.0"

var configPath string

func init() {
   flag.StringVar(&configPath,"config-path", "./config/config.yaml", "Path to application config file")
}

func main() {
    flag.Parse()

    cfg := config.New(configPath)
    logger := mrlib.NewLogger(cfg.Log.Level, !cfg.Log.NoColor)

    logger.Info("APP VERSION: %s", appVersion)

    if cfg.Debug {
      logger.Info("DEBUG MODE: ON")
    }

    logger.Info("LOG LEVEL: %s", cfg.Log.Level)
    logger.Info("APP PATH: %s", cfg.AppPath)
    logger.Info("CONFIG PATH: %s", configPath)

    translator := mrlib.NewTranslator(
        logger,
        mrlib.TranslatorOptions{
            DirPath: cfg.Translation.DirPath,
            FileType: cfg.Translation.FileType,
            LangCodes: mrlang.CastToLangCodes(cfg.Translation.LangCodes...),
        },
    )

    app.Run(cfg, logger, translator)
}