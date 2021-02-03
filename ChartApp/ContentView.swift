import SwiftUI

struct ContentView: View {
  @State var ChartWeekNum = 0
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: UIScreen.main.bounds.height / 10) {
        Text("Vertical Bar Chart")
          .font(.largeTitle)
          .bold()
          .foregroundColor(.white)
          .padding(.bottom)
        VBarChart(ChartWeekNum: self.$ChartWeekNum)
        
        Text("Horizonal Bar Chart")
          .font(.largeTitle)
          .bold()
          .foregroundColor(.white)
          .padding(.bottom)
        HBarChart(ChartWeekNum: self.$ChartWeekNum)
        
        Text("Circle Chart")
          .font(.largeTitle)
          .bold()
          .foregroundColor(.white)
          .padding(.bottom)
        CircleChart(ChartWeekNum: self.$ChartWeekNum)
      }
    }
    .padding(.horizontal, 10)
  }
}

struct VBarChart: View {
  @Binding var ChartWeekNum: Int
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<data.count) {num in
        VStack(spacing: 0) {
          Text("\(data[num].battiri)")
            .foregroundColor(.gray)
          
          ZStack (alignment: .bottom) {
            Rectangle()
              .frame(
                width: (UIScreen.main.bounds.width - 80) / 7 ,
                height: CGFloat(UIScreen.main.bounds.height / 3)
            )
              .foregroundColor(.black)
              .cornerRadius(5)
              .padding(.horizontal, 5)
            
            Rectangle()
              .frame(
                width: (UIScreen.main.bounds.width - 80) / 7 ,
                height: CGFloat(Int(UIScreen.main.bounds.height / 3) * data[num].calorie / 2000)
            )
              .foregroundColor(data[num].color)
              .cornerRadius(5)
              .padding(.horizontal, 5)
              .onTapGesture {
                self.ChartWeekNum = num
            }
          }
          Text("\(data[num].km) 2020")
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
        }
      }
    }
  }
}

struct HBarChart: View {
  @Binding var ChartWeekNum: Int
  
  var body: some View {
    VStack(spacing: 20) {
      HBar(barValue: data[ChartWeekNum].battiri, barLength: 100, typeText: "Battiri")
      HBar(barValue: data[ChartWeekNum].calorie, barLength: 3000, typeText: "Calorie")
      HBar(barValue: data[ChartWeekNum].km, barLength: 50, typeText: "Km")
    }
  }
}

struct HBar: View {
  let barValue: Int
  let barLength: Int
  let typeText: String
  
  var body: some View {
    HStack(spacing: 0) {
      Image(systemName: "bolt.fill")
        .resizable()
        .frame(width: 20, height: 20)
        .padding(.trailing, 5)
      Text(typeText)
        .font(.caption)
        .foregroundColor(.gray)
      
      Spacer()
      
      ZStack(alignment: .trailing) {
        Rectangle()
          .frame(
            width: CGFloat(Int(UIScreen.main.bounds.width / 1.3) * barValue / barLength),
            height: 30
        )
          .cornerRadius(5)
          .foregroundColor(
            typeText == "Battiri"
              ? Color.red
              : (
                typeText == "Calorie"
                  ? Color.blue
                  : Color.yellow
            )
        )
        
        Text("\(barValue) \(typeText)")
          .foregroundColor(.gray)
          .padding(.trailing, 10)
      }
    }
  }
}

struct CircleChart: View {
  @Binding var ChartWeekNum: Int
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 5) {
        HStack(spacing: 0) {
          Circle()
            .foregroundColor(.red)
            .frame(width: 10, height:10)
          
          Text("Bpm")
            .foregroundColor(.gray)
        }
        HStack(spacing: 0) {
          Circle()
            .foregroundColor(.blue)
            .frame(width: 10, height:10)
          
          Text("Calorie")
            .foregroundColor(.gray)
        }
        HStack(spacing: 0) {
          Circle()
            .foregroundColor(.yellow)
            .frame(width: 10, height:10)
          
          Text("Km")
            .foregroundColor(.gray)
        }
      }
      .padding(.trailing, 80)
      
      Group {
        ZStack {
          Circle()
            .trim(from: 0, to: CGFloat(Double(data[ChartWeekNum].battiri) / 100.0))
            .stroke(Color.red, style: StrokeStyle(lineWidth: 12, lineCap: .round))
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: -90))
          Circle()
            .trim(from: 0, to: CGFloat(Double(data[ChartWeekNum].calorie) / 3000.0))
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: -90))
          Circle()
            .trim(from: 0, to: CGFloat(Double(data[ChartWeekNum].km) / 50.0))
            .stroke(Color.yellow, style: StrokeStyle(lineWidth: 12, lineCap: .round))
            .frame(width: 150, height: 150)
            .rotationEffect(Angle(degrees: -90))
        }
      }
    }
  }
}

struct Chart: Identifiable {
  
  var id: Int
  var battiri: Int
  var calorie: Int
  var km: Int
  var color: Color
}

var data = [
  Chart(id: 0, battiri: 65, calorie: 1615, km: 27, color: Color.orange),
  Chart(id: 1, battiri: 55, calorie: 815, km: 17, color: Color.blue),
  Chart(id: 2, battiri: 85, calorie: 1215, km: 23, color: Color.green),
  Chart(id: 3, battiri: 25, calorie: 415, km: 35, color: Color.red),
  Chart(id: 4, battiri: 15, calorie: 1715, km: 37, color: Color.yellow),
  Chart(id: 5, battiri: 35, calorie: 1015, km: 26, color: Color.purple),
  Chart(id: 6, battiri: 35, calorie: 1315, km: 27, color: Color.pink)
]
