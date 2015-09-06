module InvoicesHelper
  def time_format(date)
    "#{date.strftime("%d")} #{date.strftime("%B")}, #{date.strftime("%G")}"
  end
  def full_name(first_name, last_name={})
  #  "#{first_name}" " " "#{last_name}"
    [first_name, last_name].join(' ')
  end
  def social_security(num1={}, num2={}, num3={})
    #[num1, num2, num3 ].reject(&:nil?).join(' ')
     base = "Not Registerd"
     if num1.nil?
       base
     else
      "#{num1} - #{num2} - #{num3}"
    end
  end
  def licence(licence)
    base = "Not Registerd"
    if licence.nil?
      base
    else
      licence
    end
  end
  def status_invoice id
     if id.to_i == 2
       "label label-danger"
    elsif id.to_i == 1
       "label label-primary"
     end
  end
  def status_print id
     if id.to_i == 2
       "unpaid"
    elsif id.to_i == 1
       "paid"
     end
  end

  def phone_number(country, area = {}, number)
    "#{country} - #{area} - #{number}"
  end
  
end
