require 'faker'

namespace :pilot do
  DP_RATIO = [0.7, 0.6, 0.5]
  RIDE_TIME = {morning: Time.current.midnight + 8.hours, evening: Time.current.midnight + 16.hours}

  desc 'Start a pilot at a given company'
  task :run, [:company, :employees,:ratio] =>
               :environment do |t, args|

    if args.company && args.employees
      @company = Company.where('name LIKE ?', "%#{args.company}%").take
      number_of_employees = args.employees.to_i
      rat = args.ratio.to_i if args.ratio
      ratio = rat || 0
      puts "Using ratio #{DP_RATIO[ratio]}"
      if @company
        puts "Starting pilot at #{@company.name} with #{number_of_employees} (#{number_of_employees * DP_RATIO[ratio]} passenger / #{number_of_employees - (number_of_employees * DP_RATIO[ratio])} drivers)"
        @offices = @company.offices

        Ride.destroy_all
        @company.employees.destroy_all

        @passengers = []
        @drivers = []
        (1..number_of_employees).each do |count|
          employee = Faker::Name.name
          attrs = {:name => employee, :email => "#{employee.gsub(' ','_')}@#{@company.domain}", :address => Faker::Address.street_address, :city => 'Debrecen', :default_office => @offices[count % @offices.count]}
          if count < (number_of_employees * DP_RATIO[ratio])
            @passengers << Passenger.create(attrs)
          else
            driver = Driver.create(attrs)
            driver.type = 'Driver'
            driver.save
            @drivers << driver
          end
        end

        # for a month
        (1..10).each do |day|
          puts "Day #{day}..."
          ride_time_morning = RIDE_TIME[:morning] + day.day
          direction_morning = 'to_office'

          ride_time_evening = RIDE_TIME[:evening] + day.day
          direction_evening = 'to_home'

          @passengers.each do |passenger|
            passenger.ride_requests.create(:direction => direction_morning, :time => ride_time_morning)
            passenger.ride_requests.create(:direction => direction_evening, :time => ride_time_evening)
          end
          @drivers.each do |driver|
            driver.ride_offers.create(:direction=> direction_morning, :time=> ride_time_morning, :freeSeats => 3)
            driver.ride_offers.create(:direction=> direction_evening, :time=> ride_time_evening, :freeSeats => 3)
          end
          begin
            puts 'Matching rides...'
            Ride.match_all
            #@offices.each do |office|
            #  puts "In #{office.name} has #{office.ride_requests.count} requests wth #{office.ride_offers.count} offers"
            #  Ride.match_all_by_office office
            #  puts "======> Unmatched #{office.ride_requests.unmatched.count}"
            #end
          rescue Exception => e
            puts 'That didn\'t go well..'
            puts e.message
          ensure
            puts 'Matching rides done'
          end
          @offices.each do |office|
            puts "#{office.name} has #{office.ride_requests.count} waiting requests with #{office.ride_offers.count} offers"
            puts "======> Unmatched #{office.ride_requests.unmatched.count} Error: #{RideRequest.where(office: office, status: 'error').count}"
          end
        end
        #Ride.destroy_all
        #User.destroy_all
      else
        puts "Company '#{args.company}' not found."
      end
    else
      puts "usage rake pilot:start['company name',number of employees[,ratio]]\n" +
            "\twhere ratio=0 => 0,7-0,3\n" +
            "\twhere ratio=1 => 0,6-0,4\n" +
            "\twhere ratio=2 => 0,5-0,5\n" +
            "ie: rake pilot:start['Rinity', 100, 1]"
    end
  end

end
