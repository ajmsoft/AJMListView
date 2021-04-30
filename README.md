# AJMListView


![Swift](https://img.shields.io/badge/Swift-v5.0-orange.svg) ![Xcode](https://img.shields.io/badge/XCode-10.2-blue.svg)

A Beautiful View Controller to present Menu Item in a list. It Shows a Popup with the list of items provided with dynamic content sizing and selection callback.

![AJMListView](https://user-images.githubusercontent.com/20557360/61028815-3d1b3480-a3d7-11e9-8293-ee6e6c18b97a.gif)

## How to use?
#### Step-1 - Copy the source folder into your project
#### Step-2 - Confirm to *"UIPopoverPresentationControllerDelegate"*
    // Confirm to UIPopoverPresentationControllerDelegate and implement this method in your view controller.
    extension ViewController : UIPopoverPresentationControllerDelegate {
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }
#### Step-3 - Create your DataSource
    let item1 = ListItem(id:"1", title:"Item 1", image:#imageLiteral(resourceName: "icon_light"))
    let item2 = ListItem(id:"2", title:"Item 2", image:#imageLiteral(resourceName: "icon_light"))
    let list = [item1,item2]
#### Step-3 - Call showPopupOn method from your view controller
    // Pass the view (sender) where you want to show the popup and your datasource (list)
    showPopupOn(sender, list: list) { (item) in
            print(item.title ?? "")
    }
### BONUS
##### You can also customize the width and other properties of the popup by creating a custom popup like this 

    let vc = AJMListView.getPopupController()
    vc.width = self.view.frame.width * 0.7
    vc.dataSource = list
    vc.callback = { item in
        print(item.title ?? "")
    }
    showPopupON(sender,vc)

### Get in touch with our team of Top Rated Developers! 

![Screenshot 2021-02-24 at 11 21 15 AM](https://user-images.githubusercontent.com/79437479/111860578-84104a00-896e-11eb-82ee-587340a78d2f.png)


Must Visit -> [www.ajm.in](http://ajm.in/) 
Get a quote -> [hello@ajm.in](mailto:hello@ajm.in)

