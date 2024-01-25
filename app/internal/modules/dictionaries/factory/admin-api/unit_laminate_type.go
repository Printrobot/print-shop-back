package factory

import (
	module "print-shop-back/internal/modules/dictionaries"
	http_v1 "print-shop-back/internal/modules/dictionaries/controller/http_v1/admin-api"
	entity "print-shop-back/internal/modules/dictionaries/entity/admin-api"
	"print-shop-back/internal/modules/dictionaries/factory"
	repository "print-shop-back/internal/modules/dictionaries/infrastructure/repository/admin-api"
	usecase "print-shop-back/internal/modules/dictionaries/usecase/admin-api"

	"github.com/mondegor/go-storage/mrpostgres"
	"github.com/mondegor/go-storage/mrsql"
	"github.com/mondegor/go-webcore/mrserver"
)

func createUnitLaminateType(opts *factory.Options) ([]mrserver.HttpController, error) {
	var list []mrserver.HttpController

	if c, err := newUnitLaminateType(opts); err != nil {
		return nil, err
	} else {
		list = append(list, c)
	}

	return list, nil
}

func newUnitLaminateType(opts *factory.Options) (*http_v1.LaminateType, error) {
	metaOrderBy, err := mrsql.NewEntityMetaOrderBy(entity.LaminateType{})

	if err != nil {
		return nil, err
	}

	storage := repository.NewLaminateTypePostgres(
		opts.PostgresAdapter,
		mrsql.NewBuilderSelect(
			mrpostgres.NewSqlBuilderWhere(),
			mrpostgres.NewSqlBuilderOrderByWithDefaultSort(metaOrderBy.DefaultSort()),
			mrpostgres.NewSqlBuilderPager(module.PageSizeMax),
		),
	)
	service := usecase.NewLaminateType(storage, opts.EventBox, opts.ServiceHelper)
	controller := http_v1.NewLaminateType(
		opts.RequestParser,
		opts.ResponseSender,
		service,
		metaOrderBy,
	)

	return controller, nil
}