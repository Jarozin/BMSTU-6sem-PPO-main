package logger

import (
	"fmt"
	"io"
	"os"
	"path/filepath"
	"runtime"

	"github.com/BurntSushi/toml"
	"github.com/sirupsen/logrus"
)

type LogLevel struct {
	Level string `toml:"level"`
}

type CustomTextFormatter struct {
}

const logLevelFile = "/home/jarozin/uni/sem6/alternative/BMSTU-6sem-PPO-main/src/logger/log_level.txt"

func (f *CustomTextFormatter) Format(entry *logrus.Entry) ([]byte, error) {
	// Get the file and line number where the log was called
	_, filename, line, _ := runtime.Caller(7)

	// Get the script name from the full file path
	scriptName := filepath.Base(filename)

	// Format the log message
	message := fmt.Sprintf("[%s] [%s] [%s:%d] %s\n",
		entry.Time.Format("2006-01-02 15:04:05"), // Date-time
		entry.Level.String(),                     // Log level
		scriptName,                               // Script name
		line,                                     // Line number
		entry.Message,                            // Log message
	)

	return []byte(message), nil
}

func InitLog(filename string) (*logrus.Logger, error) {
	file, err := os.OpenFile(filename, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		return nil, err
	}

	var level LogLevel
	_, err = toml.DecodeFile(logLevelFile, &level)
	if err != nil {
		return nil, err
	}
	log := logrus.New()

	switch level.Level {
	case "info":
		log.SetLevel(logrus.InfoLevel)
	case "error":
		log.SetLevel(logrus.ErrorLevel)
	case "fatal":
		log.SetLevel(logrus.FatalLevel)
	case "debug":
		log.SetLevel(logrus.DebugLevel)
	case "trace":
		log.SetLevel(logrus.TraceLevel)
	case "warn":
		log.SetLevel(logrus.WarnLevel)
	case "panic":
		log.SetLevel(logrus.PanicLevel)
	}

	log.SetOutput(io.MultiWriter(file, os.Stdout))
	log.SetFormatter(&CustomTextFormatter{})

	log.Info("Logger initialized")

	return log, nil
}
