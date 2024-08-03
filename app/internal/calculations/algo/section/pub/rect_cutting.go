package pub

import (
	"context"

	"github.com/mondegor/print-shop-back/internal/calculations/algo/section/pub/rect/cutting/entity"
)

type (
	// RectCuttingUseCase - comment interface.
	RectCuttingUseCase interface {
		CalcQuantity(ctx context.Context, data entity.ParsedData) (entity.QuantityResult, error)
	}
)
