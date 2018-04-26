
//
//  ViewController.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/10/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITextFieldDelegate, GADBannerViewDelegate {
    
    static var TASKS_ARRAY = [Task]()
    
                    /*==============================================*/
    var isChooseColorPressed = false {
        didSet {
            if isChooseColorPressed  {
                moveElementsOffInScreenWithAnimation(buttonPressed: true)
                
            } else if !isChooseColorPressed && bottomScrollViewLayout?.constant == 70 {
                isChooseColorPressed = true
                moveElementsOffInScreenWithAnimation(buttonPressed: true)
            }
            else {
                moveElementsOffInScreenWithAnimation(buttonPressed: false)
            }
        }
    }
                    /*==============================================*/
    
    var specificColorIsChoosed:String = "#5890DB" {
        didSet{
            addTaskButton.backgroundColor = UIColor.hexColor(hex: specificColorIsChoosed)
            addTaskView.addTaskButton.backgroundColor = UIColor.hexColor(hex: specificColorIsChoosed)
            showHideDatePickerButton.backgroundColor = UIColor.hexColor(hex: specificColorIsChoosed)
        }
    }
                    /*==============================================*/
    
    var didNotificationDateIsChoosed: Date? = nil
    
//============================================================================================
//============================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadScrollViewUp()
        registerCell()
        observerKeyboardNotification()
        observeSetupViewsOrientations()
        AppDelegate().loadTasks()
        launchAdMob(enable: ENABLE_ADMOB)
        splitViewController?.delegate = self
    }
//============================================================================================
//============================================================================================
                                /* Set Up View */
                        /*==============================*/
    var bottomScrollViewLayout: NSLayoutConstraint?
    var TextFieldBottomConstant:CGFloat = 20 {
        didSet{ setupViews()  }
    }
    var addTaskButtonBottomConstant:CGFloat = 10 {
        didSet{ setupViews()    }
    }
    var bottomDatePickerViewLayout: NSLayoutConstraint?

    func setupViews() {
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(upperLine)
        view.addSubview(taskCollectionView)
        view.addSubview(taskTextField)
        view.addSubview(showAddTaskViewButton)
        view.addSubview(lowerLine)
        view.addSubview(addTaskButton)
        view.addSubview(showHideDatePickerButton)
        view.addSubview(scrollView)
        view.addSubview(chooseColorButton)
        view.addSubview(datePicker)
        
        view.addSubview(addTaskView)
        
        _ = upperLine.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 85, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
        _ = taskCollectionView.anchor(upperLine.bottomAnchor, left: view.leftAnchor, bottom: lowerLine.topAnchor, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 1, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = taskTextField.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: addTaskButton.leftAnchor, topConstant: 0, leftConstant: 20, bottomConstant: TextFieldBottomConstant, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        _ = showAddTaskViewButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: addTaskButton.leftAnchor, topConstant: 0, leftConstant: 20, bottomConstant: TextFieldBottomConstant, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        _ = lowerLine.anchor(nil, left: view.leftAnchor, bottom: taskTextField.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0.8)
        
        _ = addTaskButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: addTaskButtonBottomConstant, rightConstant: 5, widthConstant: 40, heightConstant: 40)
        
        bottomScrollViewLayout = scrollView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -70, rightConstant: 0, widthConstant: 0, heightConstant: 70)[1]
        
        _ = chooseColorButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        _ = showHideDatePickerButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 40, heightConstant: 40)
        
        bottomDatePickerViewLayout = datePicker.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -200, rightConstant: 0, widthConstant: 0, heightConstant: 200)[1]
        
        //_ = addTaskView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        _ = addTaskView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 500)
    }

    func observeSetupViewsOrientations() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupViews_LandscapeMode), name: .UIDeviceOrientationDidChange, object: nil)
    }
    @objc func setupViews_LandscapeMode() {
        taskCollectionView.collectionViewLayout.invalidateLayout()
    }

    let addTaskView: AddTaskView = {
        let view = AddTaskView()
        view.isHidden = true

        return view
    }()
    
    let upperLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        
        return line
    }()
    let lowerLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        
        return line
    }()
    lazy var taskTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a todo..."
        tf.delegate = self
        
        return tf
    }()
    let showAddTaskViewButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(showAddTaskView), for: .touchUpInside)
        
        return btn
    }()
    let addTaskButton: UIButton = {
        let btn = UIButton(type: .system)
//        btn.setTitle("+", for: .normal)
        btn.setImage(UIImage(named: "addBtnPink") , for: UIControlState.normal)
        btn.setImage(#imageLiteral(resourceName: "addBtnPink"), for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.titleEdgeInsets = UIEdgeInsetsMake(7, 11, 10, 10)
        let color = COLORS[0]
        btn.backgroundColor = UIColor.hexColor(hex: color)
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        return btn
    }()
    let showHideDatePickerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "notification_Bell_Sign"), for: .normal)
        btn.tintColor = .black
        let color = COLORS[0]
        btn.backgroundColor = UIColor.hexColor(hex: color)
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.addTarget(self, action: #selector(showHideDatePickerLogic), for: .touchUpInside)
        
        return btn
    }()
    lazy var taskCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 70)
        sv.clipsToBounds = true
        sv.backgroundColor = UIColor.white
        sv.showsHorizontalScrollIndicator = true
        sv.layer.borderWidth = 0.5
        sv.layer.borderColor = UIColor.gray.cgColor
        
        return sv
    }()
    lazy var chooseColorButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "topLeftBtn"), for: .normal)
        btn.addTarget(self, action: #selector(chooseColorButtonFunc), for: .touchDown)
        
        return btn
    }()
    let datePicker:UIDatePicker = {
       let dp = UIDatePicker()
        dp.timeZone = NSTimeZone.local
        dp.backgroundColor = .white
        dp.minimumDate = NSDate(timeIntervalSinceNow: 0) as Date
        dp.addTarget(self, action: #selector(datePickValueChanged), for: .valueChanged)
        dp.layer.zPosition = 1
        
        return dp
    }()
    
//============================================================================================
//============================================================================================
                                /* UICollectionView */
                        /*=================================*/
    
    private let cellIdentifier = "CellIdentifier"
    private let introCellIdentifier = "IntroID"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ViewController.TASKS_ARRAY.isEmpty ? 1 : ViewController.TASKS_ARRAY.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ViewController.TASKS_ARRAY.isEmpty {
             return collectionView.dequeueReusableCell(withReuseIdentifier: introCellIdentifier, for: indexPath)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TaskCollectionViewCell
        
        cell.indexNumber = indexPath.item
        cell.currentTask = ViewController.TASKS_ARRAY[indexPath.item]
        UIView.cellFromSmallToBig(cell: cell)
        addingSwipeGestureToCell(cell: cell)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ViewController.TASKS_ARRAY.isEmpty ? CGSize(width: view.bounds.width, height: 100) : CGSize(width: view.bounds.width, height: 70)
    }
                                /* Reorder the cells */
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = ViewController.TASKS_ARRAY[sourceIndexPath.item]
        ViewController.TASKS_ARRAY[sourceIndexPath.row] = ViewController.TASKS_ARRAY[destinationIndexPath.row]
        ViewController.TASKS_ARRAY[destinationIndexPath.row] = itemToMove
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let SelectedTask: Task!
        
        if ViewController.TASKS_ARRAY.isEmpty {
            SelectedTask = Task(task: "New to do name", details: "Add desciption", createdAt: Date(), color: COLORS[0], isDone: true, notificationTime: nil)
        } else {
            SelectedTask = ViewController.TASKS_ARRAY[indexPath.item]
        }
        let detailVc = DetailsController()
        detailVc.currentTask = SelectedTask
        splitViewController?.showDetailViewController(detailVc, sender: nil)

    }
                    /*===============================================*/
                    /*===============================================*/
    func registerCell(){
        taskCollectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        taskCollectionView.register(IntroCVCell.self, forCellWithReuseIdentifier: introCellIdentifier)
    }
    
//============================================================================================
//============================================================================================
                                    /* Delete Cell Functions */
                            /*==============================*/
    func addingSwipeGestureToCell(cell: UICollectionViewCell){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(deleteOnceSwipedWithAnimation))
        swipeLeft.direction = .left
        cell.addGestureRecognizer(swipeLeft)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        self.taskCollectionView.addGestureRecognizer(longPressGesture)
    }
    @objc func deleteOnceSwipedWithAnimation(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let index = self.taskCollectionView.indexPath(for: cell)?.item
        
        let localNotificationTaskIdentifier = ViewController.TASKS_ARRAY[index!].task
        AppDelegate.removeSpecificLocalNotification(withIdentifier: localNotificationTaskIdentifier)
        
        UIView.throwCellFromRightToLeftOnceDeleted(cell: cell as! TaskCollectionViewCell) { 
            ViewController.TASKS_ARRAY.remove(at: index!)
            self.taskCollectionView.reloadData()
            AppDelegate.saveTasks(tasks: ViewController.TASKS_ARRAY)
        }
        playSound(soundName: DELETE_TASK_SOUND)
    }
//============================================================================================
//============================================================================================
                        /* Handling Gestures to Reorder Cells */
                /*=====================================================*/
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.taskCollectionView.indexPathForItem(at: gesture.location(in: self.taskCollectionView)) else {
                break
            }
            taskCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            taskCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            taskCollectionView.endInteractiveMovement()
        default:
            taskCollectionView.cancelInteractiveMovement()
        }
    }
//============================================================================================
//============================================================================================
                                /* Button Functions */
                          /*==============================*/
    @objc func addTask() {
        addTaskToTASKS_ARRAY()
        self.view.endEditing(true)
        hideAddTaskView()
    }
    @objc func chooseColorButtonFunc () {
        if isChooseColorPressed {
            isChooseColorPressed = false
        } else {
            isChooseColorPressed = true
        }
    }
    @objc func datePickValueChanged() {
        didNotificationDateIsChoosed = datePicker.date
    }
    @objc func showHideDatePickerLogic() {
        bringDatePickerFromBottomScreenAndHide()
    }
    @objc func hideAddTaskView() {
        addTaskView.isHidden = true
    }
    @objc func showAddTaskView() {
        addTaskView.isHidden = false
    }
//============================================================================================
//============================================================================================
                                /* ScrollView Functions */
                            /*==============================*/
    var colorButtons = [UIButton]()
    
    func loadScrollViewUp() {
        colorButtons = generateAllAvailableColors()
        calculateWidthOfScrollViewForButtons()
    }
    func generateAllAvailableColors() -> [UIButton] {
        var buttonArray = [UIButton]()
        for x in 0..<COLORS.count {
            buttonArray.append(createColorButtons(withTag: x, tagColor: COLORS[x]))
        }
        return buttonArray
    }
    func calculateWidthOfScrollViewForButtons() {
        
        var contentWidth: CGFloat = 0.0
        var counter:CGFloat = 0.0
        
        for singleButton in colorButtons {
            let button = singleButton
            let newX: CGFloat = CGFloat((button.bounds.size.width * 2.0) * counter + 40)
            
            contentWidth = newX + 70
            scrollView.addSubview(button)
            singleButton.frame = CGRect(x: newX , y: (scrollView.frame.size.height / 2) - button.bounds.size.width/2, width: button.bounds.size.width, height: button.bounds.size.height)
            counter += 1
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: 70)
    }
    func createColorButtons(withTag tag: Int, tagColor color: String) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.backgroundColor = UIColor.hexColor(hex: color)
        button.layer.cornerRadius = button.bounds.size.width / 2
        
        button.addTarget(self, action: #selector(chooseTagColorForTask), for: .touchUpInside)
        
        return button
    }
    
    /* Gets the tag of the button and then get the color from the global variable of the same tag*/
    @objc func chooseTagColorForTask(sender: UIButton) {
        specificColorIsChoosed = COLORS[sender.tag]
        moveElementsOffInScreenWithAnimation(buttonPressed: false)
    }
//============================================================================================
//============================================================================================
                            /* Animation Functions */
                        /*==============================*/
    
    func moveElementsOffInScreenWithAnimation(buttonPressed: Bool) {
        if buttonPressed {
            if ENABLE_ADMOB {
                bottomScrollViewLayout?.constant = -50
            } else {
                bottomScrollViewLayout?.constant = 0
            }
        } else {
            bottomScrollViewLayout?.constant = 70
        }

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.view.layoutIfNeeded()

        }) { (true) in
            self.scrollView.contentOffset.x = 0
        }
    }
    func bringDatePickerFromBottomScreenAndHide() {
        if bottomDatePickerViewLayout?.constant == 0 {
            bottomDatePickerViewLayout?.constant = 200
        } else {
            bottomDatePickerViewLayout?.constant = 0
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
//============================================================================================
//============================================================================================
                            /* KeyBoard Observation */
                    /*===================================*/
    func observerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardShow(notification: NSNotification) {
                    /*  Calculate the height of the Keyboard first */
        var keyboardHeight:CGFloat = 0
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardSize.height
            }
                    /* ==================================== */
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -(keyboardHeight), width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTaskToTASKS_ARRAY()
        view.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addTaskView.isHidden = false
    }
//============================================================================================
//============================================================================================
                                /* Task Core Functions */
                            /*==============================*/
    func addTaskToTASKS_ARRAY() {
        let task = addTaskView.taskTextField.text, createdAt = Date(), color = specificColorIsChoosed, notificationTime = didNotificationDateIsChoosed, detail = addTaskView.descriptionTextView.text
        
        if task == "" {
            taskTextField.placeholder = "Please Enter a to do!"
            addTaskView.taskTextField.placeholder = "Please Enter a to do!"
            return
        }
        
        let newTaskToAppend = Task(task: task!, details: detail!, createdAt: createdAt, color: color, isDone: false, notificationTime: notificationTime)
        
        ViewController.TASKS_ARRAY.insert(newTaskToAppend, at: 0)
        taskCollectionView.reloadData()
        taskTextField.text = ""
        addTaskView.taskTextField.text = ""
        addTaskView.descriptionTextView.text = "Write the Description Here!"
        AppDelegate.saveTasks(tasks: ViewController.TASKS_ARRAY)
        playSound(soundName: ADD_TASK_SOUND)
        
        guard (notificationTime != nil) else {
            return
        }
        AppDelegate.fireUpLocalNotifications(at: notificationTime!, task: task!)
        resetDatePickerDateAndNotificationVariable()
    }
    func resetDatePickerDateAndNotificationVariable() {
        didNotificationDateIsChoosed = nil
        datePicker.date = Date()
    }
//============================================================================================
//============================================================================================
                                /* AdMob Functions */
                        /*===================================*/
    var admobInterstitial : GADInterstitial?
    var timer: Timer?
    lazy var bannerView:GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = ADMOB_BANNER_ID
        banner.rootViewController = self
        banner.delegate = self
        banner.load(GADRequest())
        banner.layer.zPosition = 2
        
        return banner
    }()

    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: ADMOB_INTERSTITIAL_ID)
        interstitial.load(GADRequest())
        return interstitial
    }
    @objc func presentInterstitial() {
        if (admobInterstitial?.isReady) != nil {
            admobInterstitial?.present(fromRootViewController: self)
        }
    }
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        //print("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        admobInterstitial = createAndLoadInterstitial()
    }
    func tryLunchInterstitialAds() {
        admobInterstitial = createAndLoadInterstitial()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target:self, selector: #selector(presentInterstitial), userInfo: nil, repeats: false)
    }
    func launchAdMob(enable: Bool) {
        if enable {
        view.addSubview(bannerView)
        _ = bannerView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
            
        tryLunchInterstitialAds()
        }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        TextFieldBottomConstant = 60
        addTaskButtonBottomConstant = 55
    }
//============================================================================================
//============================================================================================
    
    /* Play Sound Functions */
                        /*===================================*/
    var player:AVAudioPlayer = AVAudioPlayer()
    func playSound(soundName: String) {
        let path = Bundle.main.path(forResource: soundName, ofType: "mp3")
        let soundUrl = URL(fileURLWithPath: path!)
        do {
            try player = AVAudioPlayer(contentsOf: soundUrl)
            player.prepareToPlay()
            player.play()
        }catch{
            //It didn't work playing sound
        }
    }
//============================================================================================
//============================================================================================
    
}


extension ViewController: UISplitViewControllerDelegate  {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}

