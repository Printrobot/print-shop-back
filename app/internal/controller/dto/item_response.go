package dto

type (
    CreateItemResponse struct {
        ItemId string `json:"id"`
        Message string `json:"message,omitempty"`
    }
)