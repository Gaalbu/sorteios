defmodule Sorteios.Repo.Migrations.AddPrizeWinnerReservations do
  use Ecto.Migration

  def change do
    alter table(:prizes) do
      add :reserved_winner_name, :string
      add :reserved_winner_email, :string
      add :reserved_at, :utc_datetime_usec
    end

    create index(:prizes, [:room_id, :reserved_winner_email])

    create unique_index(:prizes, [:room_id, :winner_email],
             where: "winner_email IS NOT NULL",
             name: :prizes_room_id_winner_email_unique
           )
  end
end
