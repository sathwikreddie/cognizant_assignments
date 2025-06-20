public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(103, "Phone", "Electronics"),
            new Product(101, "Laptop", "Electronics"),
            new Product(104, "Shoes", "Fashion"),
            new Product(102, "Watch", "Accessories")
        };

        System.out.println(" Linear Search for productId = 104:");
        Product result1 = SearchUtil.linearSearch(products, 104);
        System.out.println(result1 != null ? result1 : "Product not found");

        SearchUtil.sortProductsById(products);

        System.out.println("\n Binary Search for productId = 104:");
        Product result2 = SearchUtil.binarySearch(products, 104);
        System.out.println(result2 != null ? result2 : "Product not found");
    }
}
