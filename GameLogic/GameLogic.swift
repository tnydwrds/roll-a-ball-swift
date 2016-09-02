import UnityEngine
import UnityEngine.UI
import System.Collections
import UnityAspect


public class PlayerController: MonoBehaviour {

    @PublicizeField
    public var speed = 10.0

    @PublicizeField
    public var countText: Text!

    @PublicizeField
    public var winText: Text!

    private var rigidBody: Rigidbody!
    private var count = 0

    func Start() {
        rigidBody = GetComponent<Rigidbody>()
        SetCountText()
        winText.text = ""
    }

    func FixedUpdate() {
        var moveHorizontal = Input.GetAxis("Horizontal")
        var moveVertical = Input.GetAxis("Vertical")
        var movement = Vector3(moveHorizontal, 0, moveVertical)
        rigidBody.AddForce(movement * speed)
    }

    func OnTriggerEnter(_ other: Collider) {
        if other.gameObject.CompareTag("PickUp") {
            other.gameObject.SetActive(false)
            count += 1
            SetCountText()
        }
    }

    func SetCountText() {
        countText.text = "Count: \(count)"

        if count >= 12 {
            winText.text = "You win!"
        }
    }

}


public class CameraController: MonoBehaviour {

    @PublicizeField
    public var player: GameObject!

    private var offeset: Vector3!

    func Start() {
        offeset = transform.position - player.transform.position
    }

    func LateUpdate() {
        transform.position = player.transform.position + offeset
    }

}


public class Rotator: MonoBehaviour {

    func Update() {
        transform.Rotate(Vector3(15, 30, 45) * Time.deltaTime)
    }

}
