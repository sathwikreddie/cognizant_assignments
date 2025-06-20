public class Main {
    public static void main(String[] args) {
        StockMarket market = new StockMarket();

        Observer mobile = new MobileApp("StockTracker Mobile");
        Observer web = new WebApp("FinWeb");

        market.registerObserver(mobile);
        market.registerObserver(web);

        System.out.println("\n Updating Stock: Apple");
        market.setStockData("Apple", 187.5);

        System.out.println("\n Updating Stock: Tesla");
        market.setStockData("Tesla", 245.9);

        System.out.println("\n Removing Mobile Observer");
        market.removeObserver(mobile);

        System.out.println("\n Updating Stock: Google");
        market.setStockData("Google", 2988.3);
    }
}
