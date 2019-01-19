

extension NumberFormatter {
    
    public static var decimalNumberFormater: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
