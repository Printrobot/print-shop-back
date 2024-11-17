-- --------------------------------------------------------------------------------------------------

CREATE TABLE printshop_controls.element_templates (
    template_id int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY CONSTRAINT pk_element_templates PRIMARY KEY,
    tag_version int4 NOT NULL DEFAULT 1 CHECK(tag_version > 0),
    param_name character varying(32) NULL,
    template_caption character varying(64) NOT NULL,
    element_type int2 NOT NULL, -- 1=GROUP, 2=ELEMENT_LIST
    element_detailing int2 NOT NULL, -- 1=NORMAL, 2=EXTENDED
    element_body jsonb NOT NULL,
    template_status int2 NOT NULL, -- 1=DRAFT, 2=ENABLED, 3=DISABLED
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NOT NULL DEFAULT NOW(),
    deleted_at timestamp with time zone NULL
);

-- --------------------------------------------------------------------------------------------------

INSERT INTO printshop_controls.element_templates (template_id, tag_version, param_name, template_caption, element_type, element_detailing, element_body, template_status, created_at, updated_at, deleted_at)
VALUES (1, 1, 'Product', 'Поля листовой продукции', 2/*ELEMENT_LIST*/, 1/*NORMAL*/, '[
  {
    "id": "%parentId%Quantity",
    "caption": "Тираж",
    "type": "NUMBER",
    "required": true,
    "view": "TEXT",
    "values": [
      {
        "id": "%parentId%_value",
        "defaultValue": 1000,
        "minValue": 1,
        "maxValue": 1000000
      }
    ],
    "measure": "шт"
  },

  {
    "id": "%parentId%SimilarTypes",
    "caption": "Видов",
    "type": "NUMBER",
    "required": true,
    "view": "TEXT",
    "values": [
      {
        "id": "%parentId%_value",
        "defaultValue": 1,
        "minValue": 1,
        "maxValue": 100
      }
    ]
  },

  {
    "id": "%parentId%FormatX",
    "caption": "Длина",
    "type": "NUMBER",
    "required": true,
    "view": "TEXT",
    "values": [
      {
        "id": "%parentId%_value",
        "defaultValue": 297,
        "minValue": 1,
        "maxValue": 1020
      }
    ],
    "measure": "мм"
  },

  {
    "id": "%parentId%FormatY",
    "caption": "Ширина",
    "type": "NUMBER",
    "required": true,
    "view": "TEXT",
    "values": [
      {
        "id": "%parentId%_value",
        "defaultValue": 210,
        "minValue": 1,
        "maxValue": 1020
      }
    ],
    "measure": "мм"
  },

  {
    "id": "%parentId%PrintType",
    "type": "NUMBER",
    "caption": "Вид печати",
    "required": true,
    "view": "RADIO",
    "values": [
      {
        "id": "%parentId%_Any",
        "caption": "Любая печать"
      },
      {
        "id": "%parentId%_Offset",
        "caption": "Офсетная печать"
      },
      {
        "id": "%parentId%_Digital",
        "caption": "Цифровая печать"
      }
    ]
  }]', 2/*ENABLED*/, '2023-07-03 16:22:50.911157', '2023-07-03 16:22:50.911157', NULL),
(2, 1, 'ProcessMedia', 'Бумага', 1/*GROUP*/, 1/*NORMAL*/, '[
  {
    "id": "%parentId%_Type",
    "caption": "Тип бумаги",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "dictionary": "media-type",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ]
  },
  {
    "id": "%parentId%_Density",
    "caption": "Плотность",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "dictionary": "media-density",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ],
    "measure": "г/м2"
  },
  {
    "id": "%parentId%_Texture",
    "caption": "Фактура",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "dictionary": "media-texture",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ]
  },
  {
    "id": "%parentId%_Color",
    "caption": "Цвет",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "dictionary": "media-color",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ]
  }
]', 2/*ENABLED*/, '2023-07-03 16:34:02.369491', '2023-07-03 16:34:02.369491', NULL),
(3, 1, 'ProcessPackaging', 'Упаковка', 1/*GROUP*/, 1/*NORMAL*/, '[
  {
    "id": "%parentId%_Type",
    "caption": "Тип упаковки",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "values": [
      {
        "id": "%parentId%_ShrinkFilm",
        "caption": "Термоусадочная пленка"
      },
      {
        "id": "%parentId%_CorrugatedBox",
        "caption": "Гофрированная коробка"
      }
    ]
  }
]', 2/*ENABLED*/, '2023-07-03 16:38:59.254920', '2023-07-03 16:38:59.254920', NULL),
(4, 1, 'ProcessPrinting', 'Печать', 1/*GROUP*/, 1/*NORMAL*/, '[
  {
    "id": "%parentId%_SideFace",
    "caption": "Лицевая сторона",
    "type": "GROUP",
    "required": true,
    "view": "BLOCK",
    "values": [
      {
        "id": "%parentId%_ColorMode",
        "caption": "Количество цветов",
        "type": "NUMBER",
        "required": true,
        "view": "COMBO",
        "values": [
          {
            "id": "%parentId%_1",
            "caption": "[ 1 ]"
          },
          {
            "id": "%parentId%_4",
            "caption": "[ 4 ]"
          }
        ]
      },

      {
        "id": "%parentId%_Varnish",
        "caption": "Лакировка",
        "type": "NUMBER",
        "required": false,
        "view": "COMBO",
        "dictionary": "varnish",
        "values": [
          {
            "id": "%parentId%_None",
            "caption": "без лакировки"
          }
        ]
      }
    ]
  },

  {
    "id": "%parentId%_SideBack",
    "caption": "Обратная сторона",
    "type": "GROUP",
    "required": false,
    "view": "BLOCK",
    "values": [
      {
        "id": "%parentId%_ColorMode",
        "caption": "Количество цветов",
        "type": "NUMBER",
        "required": true,
        "view": "COMBO",
        "values": [
          {
            "id": "%parentId%_0",
            "caption": "[ 0 ]"
          },
          {
            "id": "%parentId%_1",
            "caption": "[ 1 ]"
          },
          {
            "id": "%parentId%_4",
            "caption": "[ 4 ]"
          }
        ]
      },

      {
        "id": "%parentId%_Varnish",
        "type": "NUMBER",
        "caption": "Лакировка",
        "required": false,
        "view": "COMBO",
        "dictionary": "varnish",
        "values": [
          {
            "id": "%parentId%_None",
            "caption": "без лакировки"
          }
        ]
      }
    ]
  }
]', 2/*ENABLED*/, '2023-07-03 16:35:14.078093', '2023-07-03 16:35:14.078093', NULL),
(5, 1, 'ProcessLaminating', 'Ламинация', 1/*GROUP*/, 1/*NORMAL*/, '[
  {
    "id": "%parentId%_NumberOfSides",
    "caption": "Количество сторон",
    "type": "NUMBER",
    "required": true,
    "view": "RADIO",
    "values": [
      {
        "id": "%parentId%_OneSide",
        "caption": "Одна сторона"
      },
      {
        "id": "%parentId%_TwoSides",
        "caption": "Две стороны"
      }
    ]
  },

  {
    "id": "%parentId%_LaminatingTexture",
    "caption": "Тип ламината",
    "type": "NUMBER",
    "required": true,
    "view": "COMBO",
    "dictionary": "laminating-texture",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ]
  },

  {
    "id": "%parentId%_LaminatingThikness",
    "caption": "Толщина ламината",
    "type": "NUMBER",
    "required": true,
    "view": "COMBO",
    "dictionary": "laminating-thikness",
    "values": [
      {
        "id": "%parentId%_None",
        "caption": "не указано"
      }
    ],
    "measure": "мм"
  }
]', 2/*ENABLED*/, '2023-07-03 16:36:48.626009', '2023-07-03 16:36:48.626009', NULL);

ALTER SEQUENCE printshop_controls.element_templates_template_id_seq RESTART WITH 6;