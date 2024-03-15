package view_shared

import (
	"net/http"
	entity_shared "print-shop-back/internal/modules/provider-accounts/entity/shared"

	"github.com/mondegor/go-webcore/mrlog"
	"github.com/mondegor/go-webcore/mrserver"
	"github.com/mondegor/go-webcore/mrserver/mrparser"
)

type (
	RequestParser interface {
		mrserver.RequestParserInt64
		mrserver.RequestParserItemStatus
		mrserver.RequestParserKeyInt32
		mrserver.RequestParserListSorter
		mrserver.RequestParserListPager
		mrserver.RequestParserString
		mrserver.RequestParserValidate

		FilterPublicStatusList(r *http.Request, key string) []entity_shared.PublicStatus
	}

	Parser struct {
		*mrparser.Int64
		*mrparser.ItemStatus
		*mrparser.KeyInt32
		*mrparser.ListSorter
		*mrparser.ListPager
		*mrparser.String
		*mrparser.Validator
	}
)

func NewParser(
	p1 *mrparser.Int64,
	p2 *mrparser.ItemStatus,
	p3 *mrparser.KeyInt32,
	p4 *mrparser.ListSorter,
	p5 *mrparser.ListPager,
	p6 *mrparser.String,
	p7 *mrparser.Validator,
) *Parser {
	return &Parser{
		Int64:      p1,
		ItemStatus: p2,
		KeyInt32:   p3,
		ListSorter: p4,
		ListPager:  p5,
		String:     p6,
		Validator:  p7,
	}
}

func (p *Parser) FilterPublicStatusList(r *http.Request, key string) []entity_shared.PublicStatus {
	items, err := parseFilterPublicStatusList(
		r,
		key,
		[]entity_shared.PublicStatus{
			entity_shared.PublicStatusPublished,
			entity_shared.PublicStatusPublishedShared,
		},
	)

	if err != nil {
		mrlog.Ctx(r.Context()).Warn().Err(err).Send()
	}

	return items
}
