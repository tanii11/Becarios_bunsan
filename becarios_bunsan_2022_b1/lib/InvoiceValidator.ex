defmodule InvoiceValidator do  
    def validate_dates(%DateTime{} = emisor_date, %DateTime{} = pac_date) do
        
        if DateTime.diff(pac_date, emisor_date)/60/60/24  > 3 do 
                "ERROR: Invoice was issued more than 72 hrs before received by the PAC"
        else
            if DateTime.diff(emisor_date, pac_date)/60 > 5 do
                "ERROR: Invoice is more than 5 mins ahead in time"
            else
                :ok
            end
        end
    end
end